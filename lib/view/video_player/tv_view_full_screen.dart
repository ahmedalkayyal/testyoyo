import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoPlayerFullscreenWidget extends StatelessWidget {
     const VideoPlayerFullscreenWidget({Key? key,required this.controller}) : super(key: key);
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    final size = controller.value.size;
    final width = size.width;
    final height = size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        SizedBox(
          width: width,
          height: height,
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller),
          ),
        ),
      ],
    );
  }
}
