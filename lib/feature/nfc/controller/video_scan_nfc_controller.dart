import 'dart:io';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../core/base/base_controller/base_controller.dart';

class VideoScanNfcController extends BaseGetxController {
  late YoutubePlayerController videoPlayerController;

  @override
  void onInit() {
    String videoId = '';

    if (Platform.isAndroid) {
      videoId = '-P3il8ShK74';
    } else {
      videoId = '2IjUYJmcIDw';
    }

    videoPlayerController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        // mute: false,
        controlsVisibleAtStart: false, // Ẩn điều khiển khi bắt đầu
        disableDragSeek: true, // Vô hiệu hóa kéo để tua
      ),
    );
    super.onInit();
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    super.onClose();
  }
}
