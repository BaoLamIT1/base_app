import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../values/colors.dart';

/// [isDarkMode] hiện tại để 2 Theme dark và light
ThemeData getThemeByAppTheme([bool isDarkMode = true]) {
  ThemeData base = isDarkMode ? ThemeData.dark() : ThemeData.light();
  IconThemeData buildIconTheme() {
    Color iconColor = isDarkMode ? Colors.white : Colors.black;

    return IconThemeData(color: iconColor, size: 20.0);
  }

  AppBarTheme buildAppBarTheme() {
    return base.appBarTheme.copyWith(
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
            isDarkMode ? Brightness.dark : Brightness.light,
      ),
      color: AppColors.primaryColor,
      iconTheme: buildIconTheme(),
    );
  }

  TextTheme basicTextTheme() {
    final TextTheme textTheme = base.textTheme;

    Color textColor = isDarkMode ? Colors.white : Colors.black87;
    Color subTextColor = isDarkMode ? Colors.white54 : Colors.black54;
    return TextTheme(
      // headline
      displayLarge: textTheme.displayLarge!.copyWith(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      displayMedium: textTheme.displayMedium!.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      displaySmall: textTheme.displaySmall!.copyWith(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      headlineMedium: textTheme.headlineMedium!.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      headlineSmall: textTheme.headlineSmall!.copyWith(
        fontSize: 22,
        color: textColor,
      ),
      titleLarge: textTheme.titleLarge!.copyWith(
        fontSize: 20,
        color: textColor,
      ),
      // subtitle
      titleMedium: TextStyle(fontSize: 14, color: textColor),
      titleSmall: textTheme.titleSmall!.copyWith(
        fontSize: 12,
        color: subTextColor,
      ),
      // body
      bodyLarge: textTheme.bodyLarge!.copyWith(fontSize: 16, color: textColor),
      bodyMedium: textTheme.bodyMedium!.copyWith(
        fontSize: 14,
        color: subTextColor,
      ),
      // bodySmall - chú thích trong app
      bodySmall: textTheme.bodySmall!.copyWith(fontSize: 12, color: textColor),
      // button
      labelLarge: textTheme.labelLarge!.copyWith(
        fontSize: 14,
        color: textColor,
      ),
    ).apply(fontFamily: 'SanFranciscoDisplay');
  }

  return base.copyWith(
    // themes
    textTheme: basicTextTheme(),
    iconTheme: buildIconTheme(),
    appBarTheme: buildAppBarTheme(),
    brightness: isDarkMode ? Brightness.dark : Brightness.light,
    bottomAppBarTheme: _buildBottomAppBarTheme(base),
    bottomSheetTheme: _buildBottomSheetTheme(base),
    tabBarTheme: base.tabBarTheme.copyWith(
      labelColor: isDarkMode ? AppColors.accentColor : Colors.white60,
      unselectedLabelColor: AppColors.accentColor,
    ),
    // colors
    primaryColor: isDarkMode ? AppColors.dsGray1 : Colors.pink[50],
    indicatorColor: Colors.grey,
    textButtonTheme: _textButtonThemeData(base),
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColorPrimary,
    cardColor: isDarkMode ? AppColors.dsGray1 : Colors.pink[50],
    secondaryHeaderColor: AppColors.dsGray1,
    dialogTheme: const DialogThemeData(backgroundColor: AppColors.accentColor),
  );
  // colorScheme: ColorScheme(
  //     background: isDarkMode ? AppColors.backgroundColor : Colors.white54));
}

ButtonThemeData _buildButtonTheme(ThemeData base) {
  return base.buttonTheme.copyWith(
    height: 50,
    minWidth: 5,
    // Them vao de context menu copy, paste tren Samsung khong bi soc vang
    buttonColor: AppColors.dsGray1,
    textTheme: ButtonTextTheme.accent,
    colorScheme: base.colorScheme.copyWith(
      primary: Colors.white,
      secondary: Colors.white,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
  );
}

TextButtonThemeData _textButtonThemeData(ThemeData base) {
  return TextButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStateProperty.all(base.textTheme.titleMedium),
      overlayColor: WidgetStateProperty.all(Colors.white38),
    ),
  );
}

BottomAppBarTheme _buildBottomAppBarTheme(ThemeData base) {
  return base.bottomAppBarTheme.copyWith(color: Colors.white);
}

BottomSheetThemeData _buildBottomSheetTheme(ThemeData base) {
  return base.bottomSheetTheme.copyWith(
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
  );
}
