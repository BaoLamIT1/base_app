import 'package:flutter/material.dart';

import '../../../core/core.src.dart';

class BaseButton {
  static DateTime? _dateTime;

  static Widget buildButton(
    String btnTitle,
    Function function, {
    List<Color> colors = AppColors.colorLoading,
    bool isLoading = false,
    bool showLoading = true,
    double borderRadiusBtn = AppDimens.paddingVerySmall,
    Color? colorText,
    bool isGradient = true,
    bool isShow = true,
    double? fontBtn,
    double? height,
    TextStyle? textStyle,
    Border? border,
  }) {
    return SdsElevatedButton(
      title: btnTitle,
      height: height ?? AppDimens.sizeImageLogo,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(borderRadiusBtn),
        border: border ?? const Border(),
      ),
      onPressed: () => !isLoading ? function() : null,
      isLoading: isLoading,
      showLoading: showLoading,
      colors: colors,
      textStyle: textStyle ?? TextStyle(color: colorText ?? Colors.white),
      loadingBuilder: SizedBox(
        height: AppDimens.btnSmall,
        width: AppDimens.btnSmall,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          backgroundColor: AppColors.bg(),
        ),
      ),
    );
  }

  static Widget buildButtonChild(
    String btnTitle,
    Function function, {
    double? height,
    bool isLoading = false,
    bool showLoading = true,
    List<Color> colors = AppColors.colorBtnPrimaryBlue,
  }) {
    return BaseButton.buildButton(
      btnTitle,
      function,
      borderRadiusBtn: AppDimens.paddingVerySmall,
      height: height,
      showLoading: showLoading,
      isLoading: isLoading,
      colors: colors,
    );
  }

  /// Sử dụng để tránh trường hợp click liên tiếp khi thực hiện function
  static Widget baseOnAction({
    required Function? onTap,
    required Widget child,
  }) {
    return GestureDetector(
      onTap: () {
        DateTime now = DateTime.now();
        if (_dateTime == null ||
            now.difference(_dateTime!) > const Duration(seconds: 1)) {
          _dateTime = now;
          onTap!();
        }
      },
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}
