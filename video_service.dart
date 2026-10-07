import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/video_item.dart';

class VideoService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<VideoItem>> watchVideos() {
    return _db
        .collection('videos')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => VideoItem.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  Stream<bool> watchLiked(String videoId) {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return Stream.value(false);

    return _db
        .collection('videos')
        .doc(videoId)
        .collection('likes')
        .doc(uid)
        .snapshots()
        .map((doc) => doc.exists);
  }

  Future<void> toggleLike(VideoItem video) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final videoRef = _db.collection('videos').doc(video.id);
    final likeRef = videoRef.collection('likes').doc(uid);

    await _db.runTransaction((tx) async {
      final likeSnap = await tx.get(likeRef);
      final videoSnap = await tx.get(videoRef);

      final current =
          (videoSnap.data()?['likeCount'] ?? video.likeCount) as int;

      if (likeSnap.exists) {
        tx.delete(likeRef);
        tx.update(videoRef, {
          'likeCount': current > 0 ? current - 1 : 0,
        });
      } else {
        tx.set(likeRef, {
          'createdAt': FieldValue.serverTimestamp(),
        });
        tx.set(videoRef, {
          'likeCount': current + 1,
        }, SetOptions(merge: true));
      }
    });
  }
}
