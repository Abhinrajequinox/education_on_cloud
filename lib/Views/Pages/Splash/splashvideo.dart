import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class Splashvideo extends StatefulWidget {
  const Splashvideo({super.key});

  @override
  State<Splashvideo> createState() => _SplashvideoState();
}

class _SplashvideoState extends State<Splashvideo> {    
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager=FlickManager(videoPlayerController: VideoPlayerController.asset('lib/Assets/Onboard/splashvideo.mp4'));
  // WakelockPlus.enable();
  }
@override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: AspectRatio(aspectRatio: 16/9,child: FlickVideoPlayer(flickManager: flickManager),),),);
  }
}
