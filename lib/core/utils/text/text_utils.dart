import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../values/colors.dart';
import '../../values/dimens.dart';

/// VerySmall - [AppDimens.sizeTextSmaller] = 12
/// Small - [AppDimens.sizeTextSmall] = 14
/// Medium - [AppDimens.sizeTextMediumTb] = 16
/// Large - [AppDimens.sizeTextLarge] = 20
/// Large Supper - [AppDimens.sizeTextSupperLarge] = 24
///
/// normal - [FontWeight.normal] = w400
/// bold - [FontWeight.bold] = w700

// Có thể bổ sung
enum StyleEnum {
  /// VerySmall, normal
  MbTitle1Bold,
  MbTitle2Bold,
  MbTitle3Bold,
  MbSubRegular,
  NunitoInput,
  MbBodyRegular,
  MbBodyBold,
  BodyBold,
  DBBodySub,
  MbBodyBold11,
  WebSubRegular,
  SemiBold,
  InterMedium,
  RegularBold,
  RobotoRegular,
}

class TextUtils extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final Color? color;
  final double? wordSpacing;
  final StyleEnum? availableStyle;
  final int? maxLine;
  final TextAlign? textAlign;
  final TextStyle? customStyle;
  final FontStyle? fontStyle;
  final bool? isOverflow;
  final TextDecoration? textDecoration;
  final Color? colorDecoration;

  const TextUtils({
    super.key,
    required this.text,
    this.size,
    this.fontWeight,
    this.color,
    this.wordSpacing,
    this.availableStyle,
    this.maxLine,
    this.textAlign,
    this.customStyle,
    this.fontStyle,
    this.isOverflow,
    this.textDecoration,
    this.colorDecoration,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle style = GoogleFonts.nunitoSans().copyWith(
      fontSize: size ?? AppDimens.sizeTextMediumTb,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? AppColors.basicBlack,
      wordSpacing: wordSpacing,
      overflow: TextOverflow.ellipsis,
      fontStyle: fontStyle ?? FontStyle.normal,
      decoration: textDecoration ?? TextDecoration.none,
      decorationColor: colorDecoration ?? colorDecoration,
    );

    if (availableStyle != null) {
      switch (availableStyle!) {
        case StyleEnum.MbTitle3Bold:
          style = style.copyWith(
            fontSize: AppDimens.sizeTextSmall,
            fontWeight: FontWeight.w700,
          );
          break;
        case StyleEnum.MbTitle1Bold:
          style = style.copyWith(
            fontSize: AppDimens.sizeTextMediumTb,
            fontWeight: FontWeight.w800,
          );
          break;
        case StyleEnum.MbTitle2Bold:
          style = style.copyWith(
            fontSize: AppDimens.sizeTextSupperLarge,
            fontWeight: FontWeight.w800,
          );
          break;
        case StyleEnum.MbSubRegular:
          style = style.copyWith(
            fontSize: AppDimens.sizeTextSmaller,
            fontWeight: FontWeight.w400,
          );
          break;
        case StyleEnum.NunitoInput:
          style = style.copyWith(
            fontSize: AppDimens.sizeTextSmall,
            fontWeight: FontWeight.w400,
          );
          break;
        case StyleEnum.MbBodyRegular:
          style = style.copyWith(
            fontSize: AppDimens.sizeTextSmall,
            fontWeight: FontWeight.w400,
          );
          break;
        case StyleEnum.MbBodyBold:
          style = style.copyWith(
            fontSize: AppDimens.sizeTextSmall,
            fontWeight: FontWeight.w700,
          );
          break;
        case StyleEnum.BodyBold:
          style = style.copyWith(
            fontSize: AppDimens.sizeTextSmall,
            fontWeight: FontWeight.w600,
          );
          break;
        case StyleEnum.DBBodySub:
          style = style.copyWith(
            fontSize: AppDimens.sizeTextSmaller,
            fontWeight: FontWeight.w400,
          );
        case StyleEnum.MbBodyBold11:
          style = style.copyWith(
            fontSize: AppDimens.sizeTextSmaller,
            fontWeight: FontWeight.w700,
          );
          break;
        case StyleEnum.WebSubRegular:
          style = style.copyWith(
            fontSize: AppDimens.sizeTextSmaller,
            fontWeight: FontWeight.w500,
          );
        case StyleEnum.SemiBold:
          style = style.copyWith(
            fontSize: AppDimens.sizeTextSmaller,
            fontWeight: FontWeight.w600,
          );
        case StyleEnum.InterMedium:
          style = style.copyWith(
            fontSize: AppDimens.sizeTextMediumTb,
            fontWeight: FontWeight.w700,
          );
        case StyleEnum.RegularBold:
          style = style.copyWith(
            fontSize: AppDimens.sizeTextSmallTb,
            fontWeight: FontWeight.w700,
          );
        case StyleEnum.RobotoRegular:
          style = style.copyWith(
            fontSize: AppDimens.sizeTextSmallTb,
            fontWeight: FontWeight.w400,
          );
          break;
      }
    }
    return Text(
      text,
      style: customStyle ?? style,
      maxLines: maxLine ?? 1,
      textAlign: textAlign,
      overflow: isOverflow ?? false ? TextOverflow.clip : null,
      softWrap: true,
    );
  }
}
