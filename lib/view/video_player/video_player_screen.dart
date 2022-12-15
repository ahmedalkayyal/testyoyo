import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testyoyo/view/video_player/tv_view_full_screen.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.videoUrl);
  }

  @override
  void dispose() {
    controller.dispose();
    _setAllOrientation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black,leading: IconButton(onPressed:(){
        Navigator.of(context).pop(controller.dispose());
      } ,icon: Icon(Icons.arrow_back_sharp),color: Colors.white,)),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width*0.79,
                    child: VideoProgressIndicator(controller, allowScrubbing: true,colors:
                    VideoProgressColors(playedColor: Colors.redAccent.shade100),),),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.08,
                  child: IconButton(
                    onPressed: () {
                      SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack,);
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>
                            VideoPlayerFullscreenWidget(controller: controller,),),);
                    },
                    icon: const Icon(Icons.fullscreen, color: Colors.grey,),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.02,
              width: double.infinity,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const SizedBox(
                  width: 16,
                ),
                MaterialButton(
                  color: Colors.grey.shade600,
                  onPressed: () async {
                    if (controller.value.isPlaying) {
                      setState(() {
                        controller.value.isPlaying == false;
                      });
                      controller.pause();
                    } else {
                      controller.play();
                    }
                  },
                  child: Icon(
                    controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.addListener(() {
      setState(() {});
    });
    //controller.setLooping(true);
    controller.initialize().then((_) => setState(() {}));
    controller.play();
  }

  Future landScape() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future _setAllOrientation() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  Widget buildVideoPlayer() =>
      buildFullScreen(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),

        ),
      );

  Widget buildFullScreen({
    required Widget child,
  }) {
    final size = controller.value.size;
    final width = size.width;
    final height = size.height;

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(width: width, height: height, child: child),
    );
  }
}