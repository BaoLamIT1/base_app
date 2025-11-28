import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../utils/text/text_utils.dart';
import '../../values/colors.dart';
import '../../values/dimens.dart';

class SdsElevatedButton extends StatelessWidget {
  final String title;

  final VoidCallback? onPressed;

  final VoidCallback? onLongPress;

  final Widget? loadingBuilder;

  final List<Color> colors;

  final double height;

  final TextStyle? textStyle;

  final bool isLoading;

  final bool showLoading;

  final Decoration? decoration;

  final ButtonStyle? style;

  final double? textScaleFactor;

  const SdsElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.loadingBuilder,
    this.colors = AppColors.colorLoading,
    this.height = AppDimens.btnMedium,
    this.isLoading = false,
    this.showLoading = true,
    this.onLongPress,
    this.decoration,
    this.style,
    this.textStyle,
    this.textScaleFactor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration:
          decoration ??
          BoxDecoration(
            gradient: LinearGradient(colors: colors),
            borderRadius: BorderRadius.circular(8),
          ),
      child: ElevatedButton(
        onPressed: !isLoading ? () => onPressed?.call() : () {},
        onLongPress: onLongPress,
        style:
            style ??
            ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
        child: Stack(
          children: [
            Center(
              child:
                  textStyle != null
                      ? Text(
                        title,
                        style: textStyle,
                        textScaleFactor: textScaleFactor,
                      )
                      : TextUtils(
                        text: title,
                        color: AppColors.white,
                        availableStyle: StyleEnum.MbBodyBold,
                      ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Visibility(
                visible: isLoading && showLoading,
                child:
                    loadingBuilder ??
                    const SizedBox(
                      height: AppDimens.btnSmall,
                      width: AppDimens.btnSmall,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        backgroundColor: Colors.white,
                        // valueColor: AlwaysStoppedAnimation<Color>(colorError),
                      ),
                    ),
              ).paddingOnly(right: 15),
            ),
          ],
        ),
      ),
    );
  }
}
