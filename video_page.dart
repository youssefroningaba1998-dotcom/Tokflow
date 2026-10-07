import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../models/video_item.dart';
import '../services/video_service.dart';

class VideoPage extends StatefulWidget {
  final VideoItem video;

  const VideoPage({super.key, required this.video});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController? _controller;
  final _service = VideoService();
  bool _likedLocally = false;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.video.videoUrl),
    )
      ..setLooping(true)
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() {});
        _controller!.play();
      }).catchError((_) {
        if (mounted) setState(() {});
      });
  }

  Future<void> _like() async {
    if (_busy || widget.video.id.startsWith('demo-')) {
      if (widget.video.id.startsWith('demo-')) {
        setState(() => _likedLocally = !_likedLocally);
      }
      return;
    }

    setState(() => _busy = true);
    try {
      await _service.toggleLike(widget.video);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final ready = controller?.value.isInitialized ?? false;

    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: () {
            if (controller == null || !ready) return;
            setState(() {
              controller.value.isPlaying
                  ? controller.pause()
                  : controller.play();
            });
          },
          child: Container(
            color: Colors.black,
            child: ready
                ? FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: controller.value.size.width,
                      height: controller.value.size.height,
                      child: VideoPlayer(controller),
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ),

        Positioned(
          left: 16,
          right: 88,
          bottom: 34,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.video.username,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.video.caption,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),

        Positioned(
          right: 10,
          bottom: 30,
          child: Column(
            children: [
              StreamBuilder<bool>(
                stream: widget.video.id.startsWith('demo-')
                    ? Stream.value(_likedLocally)
                    : _service.watchLiked(widget.video.id),
                builder: (context, snapshot) {
                  final liked = snapshot.data ?? false;
                  return Column(
                    children: [
                      IconButton(
                        onPressed: _like,
                        iconSize: 40,
                        color: liked ? Colors.redAccent : Colors.white,
                        icon: Icon(
                          liked
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                        ),
                      ),
                      Text(
                        '${widget.video.likeCount + (liked && widget.video.id.startsWith("demo-") ? 1 : 0)}',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 14),
              const Icon(Icons.comment_rounded, size: 36),
              const SizedBox(height: 6),
              const Text('0'),
              const SizedBox(height: 18),
              const Icon(Icons.share_rounded, size: 34),
              const SizedBox(height: 6),
              const Text('Partager'),
            ],
          ),
        ),
      ],
    );
  }
}
