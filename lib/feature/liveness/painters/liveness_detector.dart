import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../../../core/values/strings.dart';
import '../../../generated/locales.g.dart';
import '../collection/liveness_collection.dart';

class LivenessDetector {
  LivenessDetector(this.faces, this.eyeOpenRightOld, this.eyeOpenLeftOld);

  //#region Khởi tạo giá trị
  var _action = "";
  double eyeOpenRightOld;
  double eyeOpenLeftOld;

  final List<Face> faces;

  // Trả về hành động của khuôn mặt người dùng
  String getUserAction(String type) {
    Face face = faces[0];
    if (face.headEulerAngleX == null || face.headEulerAngleY == null) {
      return '';
    }

    var pitch_angle = face.headEulerAngleX!; // X Axis
    var yaw_angle =
        face.headEulerAngleY!; // Y Axis (Z Axis in comment was wrong)
    double percentSmile = face.smilingProbability ?? 0;
    double eyeOpenRightNow = face.rightEyeOpenProbability ?? 0;
    double eyeOpenLeftNow = face.leftEyeOpenProbability ?? 0;

    if (type == AppStr.smile) {
      if (percentSmile > 0.6) {
        _action = LocaleKeys.app_smileAction.tr;
      }
    } else if (type == AppStr.open) {
      if ((eyeOpenRightNow - eyeOpenRightOld > 0.7) ||
          (eyeOpenLeftNow - eyeOpenLeftOld > 0.7)) {
        _action = LocaleKeys.app_blink.tr;
      }
    } else if (-10 < yaw_angle &&
        yaw_angle < 10 &&
        -10 < pitch_angle &&
        pitch_angle < 10 &&
        (eyeOpenRightNow > 0.5 || eyeOpenLeftNow > 0.5) &&
        percentSmile <= 0.6) {
      _action = LocaleKeys.app_between.tr; // neutral/straight face
    } else if (type == AppStr.yaw) {
      if (GetPlatform.isAndroid) {
        if (35 <= yaw_angle) {
          _action = LocaleKeys.app_TurnLeftFace.tr;
        } else if (-35 >= yaw_angle) {
          _action = LocaleKeys.app_TurnRightFace.tr;
        }
      } else if (GetPlatform.isIOS) {
        if (35 <= yaw_angle) {
          _action = LocaleKeys.app_TurnRightFace.tr;
        } else if (-35 >= yaw_angle) {
          _action = LocaleKeys.app_TurnLeftFace.tr;
        }
      } else {
        _action = LocaleKeys.app_undefined.tr;
      }
    } else {
      if (pitch_angle <= -20) {
        _action = LocaleKeys.app_faceDown.tr;
      } else if (pitch_angle >= 20) {
        _action = LocaleKeys.app_faceUp.tr;
      } else {
        _action = LocaleKeys.app_undefined.tr;
      }
    }

    return _action;
  }

  // Overloaded method để sử dụng với enum
  String getUserActionByEnum(LivenessStep step) {
    String type = LivenessCollection.types[step] ?? '';
    return getUserAction(type);
  }

  String liveNess(String type) {
    return getUserAction(type);
  }

  String liveNessByEnum(LivenessStep step) {
    return getUserActionByEnum(step);
  }
}
