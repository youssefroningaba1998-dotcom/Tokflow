import 'package:flutter/material.dart';

import '../models/video_item.dart';
import '../services/video_service.dart';
import '../widgets/video_page.dart';
import 'profile_screen.dart';

const demoVideos = <VideoItem>[
  VideoItem(
    id: 'demo-1',
    videoUrl:
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    username: '@tokflow',
    caption: 'Bienvenue sur TokFlow.',
    likeCount: 128,
  ),
  VideoItem(
    id: 'demo-2',
    videoUrl:
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    username: '@tokflow',
    caption: 'Découvre ton nouveau fil vidéo.',
    likeCount: 96,
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _service = VideoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<VideoItem>>(
        stream: _service.watchVideos(),
        builder: (context, snapshot) {
          final firebaseVideos = snapshot.data ?? const <VideoItem>[];
          final videos = firebaseVideos.isNotEmpty ? firebaseVideos : demoVideos;

          return Stack(
            children: [
              PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  return VideoPage(video: videos[index]);
                },
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 8,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Pour toi',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 12,
                top: MediaQuery.of(context).padding.top + 4,
                child: IconButton(
                  tooltip: 'Profil',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ProfileScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.account_circle_outlined, size: 30),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
