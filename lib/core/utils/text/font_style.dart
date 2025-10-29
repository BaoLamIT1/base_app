import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../values/colors.dart';

class FontStyleUtils {
  static TextStyle fontStyleSans({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
    Color color = AppColors.colorBlack,
    TextDecoration? textDecoration,
  }) {
    return GoogleFonts.nunitoSans().copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      decoration: textDecoration ?? TextDecoration.none,
    );
  }

  static TextStyle fontStyle(
      {double fontSize = 16,
      FontWeight fontWeight = FontWeight.w400,
      Color color = AppColors.colorBlack}) {
    return GoogleFonts.greatVibes().copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
