import 'dart:io';

import 'package:get/get.dart';

// Tỉ lệ chiều cao so với màn hình thiết kế
double ratioHeight = Get.height / AppDimens.heightDesign;
// Tỉ lệ chiều ngang so với màn hình thiết kế
double ratioWidth = Get.width / AppDimens.widthDesign;

class AppDimens {
  static const int heightDesign = 812;
  static const int widthDesign = 375;

  static double fontSize10() => 10.divSF;

  static double fontSmallest() => 12.divSF;

  static double fontSmall() => 14.divSF;

  static double fontMedium() => 16.divSF;

  static double fontBig() => 18.divSF;

  static double fontBiggest() => 20.divSF;

  static double fontSize24() => 24.divSF;

  static final double paddingDevice =
      GetPlatform.isIOS ? Get.mediaQuery.padding.bottom : paddingVerySmall;
  static const double sizeImage = 50;
  static const double sizeImageMedium = 70;
  static const double sizeImageBig = 90;

  static const double sizeImageLarge = 200;
  static const double sizeImageMax = 300;

  /// Button size
  static const double btn10 = 10;
  static const double btnSmall = 20;
  static const double btnPopup = 32;
  static const double btnMediumTb = 40;
  static const double btnMediumSB = 45;
  static const double btnMedium = 50;
  static const double btnLarge = 70;
  static const double btnDefault = 40;

  static const double sizeImageLogo = 40;

  // icon size
  static const double sizeIcon = 20;
  static const double sizeIconSmall = 12;
  static const double sizeIcon16 = 16;
  static const double sizeIconMedium = 24;
  static const double sizeIconSpinner = 30;
  static const double sizeDialogNotiIcon = 40;

  static const double heightChip = 30;
  static const double widthChip = 100;

  static const int maxLengthDescription = 250;

  static const double defaultPadding = 16.0;
  static const double paddingZero = 0;
  static const double paddingIcon = 4.0;
  static const double paddingVerySmall = 8.0;
  static const double paddingSmall = 12.0;
  static const double paddingSmalls = 2.0;
  static const double paddingMedium = 20.0;
  static const double paddingHuge = 32.0;

  // static const double paddingBig = 22.0;

  static const double showAppBarDetails = 200;
  static const double sizeAppBarBig = 120;
  static const double sizeAppBarMedium = 92;
  static const double sizeAppBar = 72;
  static const double sizeAppBarSmall = 44;

  // radiusBorder
  static const double radius8 = 8;
  static const double radius4 = 4;
  static const double radius12 = 12;
  static const double radius16 = 16;
  static const double radius20 = 20;
  static const double radius25 = 25;
  static const double radius30 = 30;
  static const double radius37 = 37;
  static const double radius100 = 100;
  static const double borderDefault = 1;

  // divider
  static const double paddingDivider = 15.0;

  // appbar
  static const double paddingSearchBarBig = 50;
  static const double paddingSearchBar = 45;
  static const double paddingSearchBarMedium = 30;
  static const double paddingSearchBarSmall = 10;

  // page config print
  static const double heightPageConfig = 0.85;
  static const double widthPageConfig = 20;
  static const double heightItem = 35;
  static const double widthItem = 4;
  static const int maxLength = 20;
  static const int maxLengthMax = 50;

  static const double sizeTextSmallest = 10;
  static const double sizeTextSmaller = 12;
  static const double sizeTextSmall = 14;
  static const double sizeTextSmallTb = 15;
  static const double sizeTextMediumTb = 16;
  static const double sizeTextMedium = 18;
  static const double sizeTextLarge = 20;
  static const double sizeTextSupperLarge = 24;
  static const double sizeNavigationBar = 90;

  //padding
  static const double padding6 = 6.0;
  static const double padding12 = 12.0;
  static const double padding14 = 14.0;
  static const double padding10 = 10.0;
  static const double padding15 = 15.0;
  static const double padding16 = 16.0;
  static const double padding17 = 17.0;
  static const double padding30 = 30.0;
  static const double padding38 = 38.0;
  static const double padding40 = 40.0;
  static const double padding20 = 20.0;
  static const double padding25 = 25.0;
  static const double padding22 = 22.0;
  static const double padding28 = 28.0;
  static const double padding9 = 9.0;
  static const double padding5 = 5.0;
  static const double padding2 = 2.0;
  static const double padding3 = 3.0;
  static const double padding4 = 4.0;
  static const double padding8 = 8.0;
  static const double scrollPadding = 150;

  //other
  static const double paddingTitleAndTextForm = 3;

  static double bottomPadding() {
    return Platform.isIOS ? AppDimens.paddingMedium : AppDimens.paddingSmall;
  }
}

extension GetSizeScreen on num {
  /// Tỉ lệ fontSize của các textStyle
  double get divSF {
    return this / Get.textScaleFactor;
  }

  // Tăng chiều dài theo font size
  double get mulSF {
    return this * Get.textScaleFactor;
  }
}
