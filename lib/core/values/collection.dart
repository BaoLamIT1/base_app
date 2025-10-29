import 'dart:ui';

import '../../gen/assets.gen.dart';
import 'colors.dart';
import 'const.dart';

/// class chứa các collection
class AppCollection {
  static Map<String, Color> mapColorBackgroundSnackBar = {
    AppConst.actionSuccess: AppColors.backgroundSuccess,
    AppConst.actionFail: AppColors.backgroundFail,
    AppConst.actionWarning: AppColors.backgroundWarning,
    AppConst.actionNotification: AppColors.backgroundNotification,
  };

  static Map<String, Color> mapColorBorderSnackBar = {
    AppConst.actionSuccess: AppColors.statusGreen,
    AppConst.actionFail: AppColors.statusRed,
    AppConst.actionWarning: AppColors.statusYellow,
    AppConst.actionNotification: AppColors.statusNoti,
  };
  static Map<String, String> mapIconSnackBar = {
    AppConst.actionSuccess: Assets.icons.iconSnackBarSuccess,
    AppConst.actionFail: Assets.icons.iconSnackBarFail,
    AppConst.actionWarning: Assets.icons.iconSnackBarWarning,
    AppConst.actionNotification: Assets.icons.iconSnackBarNotification,
  };
}
