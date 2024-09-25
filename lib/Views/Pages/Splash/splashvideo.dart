import 'package:education_on_cloud/Views/Pages/Onboarding/onboard.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/chooselanguagescreen.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/signupscreen.dart';
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

    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.asset(
        'lib/Assets/Onboard/splashvideo.mp4'
      )
    );


    WakelockPlus.enable();

    flickManager.flickVideoManager?.videoPlayerController?.addListener(() {
      if (flickManager.flickVideoManager?.videoPlayerController?.value.isInitialized ?? false) {
        if (flickManager.flickVideoManager!.videoPlayerController!.value.position >=
            flickManager.flickVideoManager!.videoPlayerController!.value.duration) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>const ChooseLanguageScreen()), 
          );
        }
      }
    });
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(60),
      child: Scaffold(
        body: Center(
      child: FittedBox(
        fit: BoxFit.fill,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Transform.rotate(
            angle: 1.5708,
            child: FlickVideoPlayer(
              flickManager: flickManager,
              flickVideoWithControls:const FlickVideoWithControls(
                controls:  null
              )
            )
          )
        )
      )
        )
      )
    );

  }
}


