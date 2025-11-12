import 'package:get/get.dart';

import '../../../core/values/strings.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locales.g.dart';

enum LivenessStep { left, right, up, neutral, smile, eyeBlink }

class LivenessCollection {
  static final Map<LivenessStep, String> questions = {
    LivenessStep.left: LocaleKeys.app_TurnLeftFace.tr,
    LivenessStep.right: LocaleKeys.app_TurnRightFace.tr,
    LivenessStep.up: LocaleKeys.app_faceUp.tr,
    LivenessStep.neutral: LocaleKeys.app_between.tr,
    LivenessStep.smile: LocaleKeys.app_smileAction.tr,
    LivenessStep.eyeBlink: LocaleKeys.app_blink.tr,
  };

  static final Map<LivenessStep, String> questionsAction = {
    LivenessStep.left: LocaleKeys.app_TurnLeftFaceTitle.tr,
    LivenessStep.right: LocaleKeys.app_TurnRightFaceTitle.tr,
    LivenessStep.up: LocaleKeys.app_faceUpTitle.tr,
    LivenessStep.neutral: LocaleKeys.app_betweenTitle.tr,
    LivenessStep.smile: LocaleKeys.app_smileTitle.tr,
    LivenessStep.eyeBlink: LocaleKeys.app_blinkTitle.tr,
  };

  static final Map<LivenessStep, String> questionsIconAction = {
    LivenessStep.left: Assets.icons.icFaceIdLeft,
    LivenessStep.right: Assets.icons.icFaceIdRight,
    LivenessStep.up: Assets.icons.icFaceIdUp,
    LivenessStep.neutral: Assets.icons.icFaceIdBetween,
    LivenessStep.smile: Assets.icons.icFaceIdSmile,
    LivenessStep.eyeBlink: Assets.icons.icFaceIdBlink,
  };

  static const Map<LivenessStep, String> types = {
    LivenessStep.left: AppStr.yaw,
    LivenessStep.right: AppStr.yaw,
    LivenessStep.up: AppStr.pitch,
    LivenessStep.neutral: AppStr.pitch,
    LivenessStep.smile: AppStr.smile,
    LivenessStep.eyeBlink: AppStr.open,
  };
}
