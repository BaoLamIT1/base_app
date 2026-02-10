import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../core/base/base_src.dart';
import '../controller/video_scan_nfc_controller.dart';

class VideoScanNfcPage extends BaseGetWidget {
  const VideoScanNfcPage({super.key});

  @override
  VideoScanNfcController get controller => Get.put(VideoScanNfcController());

  @override
  Widget buildWidgets(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: Center(
            child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                // width: 300,
                onEnded: (metaData) {
                  controller.videoPlayerController.seekTo(Duration.zero);
                  controller.videoPlayerController.pause();
                },
                controller: controller.videoPlayerController,
                showVideoProgressIndicator: true,
              ),
              builder: (context, player) {
                return const SizedBox();
              },
            ),
          ),
        ),
      ],
    );
  }
}
