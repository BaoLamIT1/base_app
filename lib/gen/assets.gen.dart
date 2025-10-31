// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/NunitoSans-Bold.ttf
  String get nunitoSansBold => 'assets/fonts/NunitoSans-Bold.ttf';

  /// File path: assets/fonts/NunitoSans-ExtraBold.ttf
  String get nunitoSansExtraBold => 'assets/fonts/NunitoSans-ExtraBold.ttf';

  /// File path: assets/fonts/NunitoSans-Regular.ttf
  String get nunitoSansRegular => 'assets/fonts/NunitoSans-Regular.ttf';

  /// File path: assets/fonts/NunitoSans-SemiBold.ttf
  String get nunitoSansSemiBold => 'assets/fonts/NunitoSans-SemiBold.ttf';

  /// List of all assets
  List<String> get values => [
    nunitoSansBold,
    nunitoSansExtraBold,
    nunitoSansRegular,
    nunitoSansSemiBold,
  ];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/ic_account.svg
  String get icAccount => 'assets/icons/ic_account.svg';

  /// File path: assets/icons/ic_home.svg
  String get icHome => 'assets/icons/ic_home.svg';

  /// File path: assets/icons/ic_home_blue.svg
  String get icHomeBlue => 'assets/icons/ic_home_blue.svg';

  /// File path: assets/icons/ic_notification.svg
  String get icNotification => 'assets/icons/ic_notification.svg';

  /// File path: assets/icons/ic_notification_blue.svg
  String get icNotificationBlue => 'assets/icons/ic_notification_blue.svg';

  /// File path: assets/icons/ic_user.svg
  String get icUser => 'assets/icons/ic_user.svg';

  /// File path: assets/icons/ic_user_blue.svg
  String get icUserBlue => 'assets/icons/ic_user_blue.svg';

  /// File path: assets/icons/icon_change_user.svg
  String get iconChangeUser => 'assets/icons/icon_change_user.svg';

  /// File path: assets/icons/icon_face_id.svg
  String get iconFaceId => 'assets/icons/icon_face_id.svg';

  /// File path: assets/icons/icon_fingerprint.svg
  String get iconFingerprint => 'assets/icons/icon_fingerprint.svg';

  /// File path: assets/icons/icon_globe.svg
  String get iconGlobe => 'assets/icons/icon_globe.svg';

  /// File path: assets/icons/icon_language_en.png
  AssetGenImage get iconLanguageEn =>
      const AssetGenImage('assets/icons/icon_language_en.png');

  /// File path: assets/icons/icon_language_vn.png
  AssetGenImage get iconLanguageVn =>
      const AssetGenImage('assets/icons/icon_language_vn.png');

  /// File path: assets/icons/icon_lock.svg
  String get iconLock => 'assets/icons/icon_lock.svg';

  /// File path: assets/icons/icon_log_out.svg
  String get iconLogOut => 'assets/icons/icon_log_out.svg';

  /// File path: assets/icons/icon_person.svg
  String get iconPerson => 'assets/icons/icon_person.svg';

  /// File path: assets/icons/icon_snack_bar_fail.svg
  String get iconSnackBarFail => 'assets/icons/icon_snack_bar_fail.svg';

  /// File path: assets/icons/icon_snack_bar_notification.svg
  String get iconSnackBarNotification =>
      'assets/icons/icon_snack_bar_notification.svg';

  /// File path: assets/icons/icon_snack_bar_success.svg
  String get iconSnackBarSuccess => 'assets/icons/icon_snack_bar_success.svg';

  /// File path: assets/icons/icon_snack_bar_warning.svg
  String get iconSnackBarWarning => 'assets/icons/icon_snack_bar_warning.svg';

  /// List of all assets
  List<dynamic> get values => [
    icAccount,
    icHome,
    icHomeBlue,
    icNotification,
    icNotificationBlue,
    icUser,
    icUserBlue,
    iconChangeUser,
    iconFaceId,
    iconFingerprint,
    iconGlobe,
    iconLanguageEn,
    iconLanguageVn,
    iconLock,
    iconLogOut,
    iconPerson,
    iconSnackBarFail,
    iconSnackBarNotification,
    iconSnackBarSuccess,
    iconSnackBarWarning,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/bg_appbar.png
  AssetGenImage get bgAppbar =>
      const AssetGenImage('assets/images/bg_appbar.png');

  /// File path: assets/images/icon_logo.png
  AssetGenImage get iconLogo =>
      const AssetGenImage('assets/images/icon_logo.png');

  /// File path: assets/images/sign_in.jpg
  AssetGenImage get signIn => const AssetGenImage('assets/images/sign_in.jpg');

  /// File path: assets/images/sign_up.png
  AssetGenImage get signUp => const AssetGenImage('assets/images/sign_up.png');

  /// List of all assets
  List<AssetGenImage> get values => [bgAppbar, iconLogo, signIn, signUp];
}

class $AssetsLocalesGen {
  const $AssetsLocalesGen();

  /// File path: assets/locales/en_US.json
  String get enUS => 'assets/locales/en_US.json';

  /// File path: assets/locales/vi_VN.json
  String get viVN => 'assets/locales/vi_VN.json';

  /// List of all assets
  List<String> get values => [enUS, viVN];
}

class Assets {
  const Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLocalesGen locales = $AssetsLocalesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
