class VideoItem {
  final String id;
  final String videoUrl;
  final String username;
  final String caption;
  final String? avatarUrl;
  final int likeCount;

  const VideoItem({
    required this.id,
    required this.videoUrl,
    required this.username,
    required this.caption,
    this.avatarUrl,
    this.likeCount = 0,
  });

  factory VideoItem.fromMap(String id, Map<String, dynamic> data) {
    return VideoItem(
      id: id,
      videoUrl: (data['videoUrl'] ?? '') as String,
      username: (data['username'] ?? 'Utilisateur') as String,
      caption: (data['caption'] ?? '') as String,
      avatarUrl: data['avatarUrl'] as String?,
      likeCount: (data['likeCount'] ?? 0) as int,
    );
  }
}
