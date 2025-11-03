import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../gen/assets.gen.dart';
import '../../base/themes/app_text_style.dart';
import '../../values/colors.dart';
import '../../values/dimens.dart';
import '../input/text_input_model.dart';
import '../utils.src.dart';

PreferredSizeWidget buildAppBar({
  bool showActions = true,
  bool showIcon = true,
  IconData? icon = Icons.arrow_back_ios,
  Color? iconColor,
  Function? onTap,
  required String titleText,
  Widget? title,
  List<Widget>? actions,
  Widget? flexibleSpace,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    leading:
        (showIcon && icon != null)
            ? IconButton(
              icon: Icon(icon, color: iconColor ?? AppColors.white),
              onPressed: onTap != null ? () => onTap() : () => Get.back(),
              iconSize: 24,
            )
            : SizedBox(),
    centerTitle: true,
    title: title ?? const SizedBox(),
    actions: actions,
    flexibleSpace:
        flexibleSpace ??
        Stack(
          children: [
            Container(
              height: 112.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.images.bgAppbar.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: TextUtils(
                  text: titleText,
                  color: AppColors.white,
                  availableStyle: StyleEnum.MbTitle1Bold,
                ),
              ),
            ),
          ],
        ),
  );
}

PreferredSizeWidget buildAppBarSearch({
  bool showActions = true,
  bool showIcon = true,
  IconData? icon = Icons.arrow_back_ios,
  Color? iconColor,
  Function? onTap,
  Widget? title,
  List<Widget>? actions,
  Widget? flexibleSpace,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    leading:
        (showIcon && icon != null)
            ? IconButton(
              icon: Icon(icon, color: iconColor ?? AppColors.white),
              onPressed: onTap != null ? () => onTap() : () => Get.back(),
              iconSize: 24,
            )
            : null,
    centerTitle: true,
    title: title ?? const SizedBox(),
    actions: actions,
    flexibleSpace:
        flexibleSpace ??
        Stack(
          children: [
            Container(
              height: 112.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.images.bgAppbar.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: TextEditingController(),
                        decoration: InputDecoration(
                          hintText: 'Tìm kiếm',
                          prefixIcon: Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (value) {
                          /// xử lý logic tìm kiếm
                        },
                      ).paddingOnly(top: 8, bottom: 8),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(
                        Assets.icons.icAccount,
                        color: AppColors.white,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
  );
}

class UtilWidgets {
  static DateTime? _dateTime;
  static int _oldFunc = 0;

  static const Widget sizedBox10 = SizedBox(height: 10);
  static const Widget sizedBox8 = SizedBox(height: 8);
  static const Widget sizedBox16 = SizedBox(height: 16);
  static const Widget sizedBox5 = SizedBox(height: 5);
  static const Widget sizedBox4 = SizedBox(height: 4);
  static const Widget sizedBoxPaddingHuge = SizedBox(
    height: AppDimens.paddingHuge,
  );
  static const Widget sizedBoxPadding = SizedBox(
    height: AppDimens.defaultPadding,
  );
  static const Widget sizedWidth4 = SizedBox(width: 4);
  static const Widget sizedWidth5 = SizedBox(width: 5);
  static const Widget sizedWidth10 = SizedBox(width: 10);
  static const Widget sizedWidth16 = SizedBox(width: 16);
  static const Widget sizedWidth8 = SizedBox(width: 8);
  static const Widget sizedWidth24 = SizedBox(width: 24);

  static Widget buildSafeArea(
    Widget childWidget, {
    double miniumBottom = 12,
    Color? color,
    bool top = false,
  }) {
    return Container(
      color: color ?? AppColors.dsGray5,
      child: SafeArea(
        top: top,
        bottom: true,
        maintainBottomViewPadding: true,
        minimum: EdgeInsets.only(bottom: miniumBottom),
        child: childWidget,
      ),
    );
  }

  static Widget imageSvg(
    String assetName, {
    final double? width,
    final double? height,
    final Color? color,
  }) {
    return SvgPicture.asset(
      assetName,
      fit: BoxFit.contain,
      height: height,
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      width: width,
    );
  }

  static Widget buildLogo(String imgLogo, double height) {
    return SizedBox(height: height, child: Image.asset(imgLogo));
  }

  static Widget buildCheckBox(
    RxBool checkBoxValue,
    String textBox, {
    Color? activeColor,
    TextStyle? styleTextBox,
  }) {
    return Row(
      children: [
        Obx(
          () => Theme(
            data: Theme.of(
              Get.context!,
            ).copyWith(unselectedWidgetColor: AppColors.white),
            child: Checkbox(
              activeColor: activeColor ?? AppColors.bgBtnBlue(),
              value: checkBoxValue.value,
              side: const BorderSide(width: 2, color: AppColors.primaryColor),
              onChanged: (value) {
                checkBoxValue.toggle();
              },
            ),
          ),
        ),
        TextUtils(
          text: textBox.tr,
          availableStyle: StyleEnum.MbBodyRegular,
          color: AppColors.colorBlack,
        ),
      ],
    );
  }

  static const Widget buildLoading = CupertinoActivityIndicator();

  static Widget buildTextScale(
    String text, {
    FontWeight? fontWeight,
    TextAlign? textAlign,
    Color? textColor,
    int? maxLines,
    double? fontSize,
    double? textScaleFactor,
    FontStyle? fontStyle,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextStyle? textStyle,
  }) {
    return Text(
      text.tr,
      maxLines: maxLines,
      textAlign: textAlign,
      textScaler: TextScaler.linear(textScaleFactor ?? 1),
      style:
          textStyle ??
          Get.textTheme.bodySmall?.copyWith(
            color: textColor,
            fontWeight: fontWeight,
            overflow: overflow,
            fontSize: fontSize ?? AppDimens.fontSmall(),
            fontStyle: fontStyle,
            decoration: decoration,
          ),
    );
  }

  static Widget buildAvatar({required String? avatar, double radius = 25}) {
    return CircleAvatar(
      radius: radius.w, // responsive theo ScreenUtil
      backgroundImage:
          avatar != null && avatar.isNotEmpty
              ? MemoryImage(base64Decode(avatar))
              : const AssetImage("assets/images/demo_user.png")
                  as ImageProvider,
      backgroundColor: Colors.grey[200],
    );
  }

  static Widget buildAppBarTitle(
    String title, {
    bool? textAlignCenter,
    Color? textColor,
  }) {
    textAlignCenter = textAlignCenter ?? GetPlatform.isAndroid;
    return buildText(
      title.tr,
      textAlign: textAlignCenter ? TextAlign.center : TextAlign.left,
      textColor: textColor ?? AppColors.white,
      fontWeight: FontWeight.bold,
      fontSize: AppDimens.fontBiggest(),
    );
  }

  static Widget buildTitle(String title) {
    return Text(
      title.tr,
      textScaler: TextScaler.noScaling,
      style: AppTextStyle.font14Bo.copyWith(color: AppColors.dsGray3),
      textAlign: TextAlign.center,
    );
  }

  static Widget buildSmartRefresherCustomFooter() {
    return CustomFooter(
      builder: (context, mode) {
        if (mode == LoadStatus.loading) {
          return const CupertinoActivityIndicator();
        } else {
          return const Opacity(
            opacity: 0.0,
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }

  static Widget buildDivider({
    double height = 1.0,
    double thickness = 1.0,
    double indent = 0.0,
    Color? color,
  }) {
    return Divider(
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: indent,
      color: color,
    );
  }

  static Widget buildTextDivider({double? horizontal}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal ?? AppDimens.paddingVerySmall,
      ),
      child: Text(
        " -" * 200,
        maxLines: 1,
        style: const TextStyle(color: AppColors.dsGray3),
      ),
    );
  }

  static Widget buildEmpty({required Function onRefresh, String? emptyStr}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        baseOnAction(
          onTap: onRefresh,
          child: const IconButton(
            icon: Icon(
              Icons.refresh,
              size: AppDimens.sizeIconMedium,
              color: Colors.white,
            ),
            onPressed: null,
          ),
        ),
        Center(
          child: Text(
            emptyStr ?? 'Không có dữ liệu',
            style: Get.theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  /// Widget cài đặt việc refresh page
  static Widget buildSmartRefresher({
    required RefreshController refreshController,
    required Widget child,
    ScrollController? scrollController,
    Function()? onRefresh,
    Function()? onLoadMore,
    bool enablePullUp = false,
    bool enablePullDown = false,
  }) {
    return SmartRefresher(
      enablePullDown: enablePullDown,
      enablePullUp: enablePullUp,
      scrollController: scrollController,
      header: const MaterialClassicHeader(),
      controller: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoadMore,
      footer: buildSmartRefresherCustomFooter(),
      child: child,
    );
  }

  static Widget buildInput(
    TextInputModel textInputModel, {
    bool readOnly = false,
  }) {
    RxBool isObscure = textInputModel.isPassword.obs;

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(textInputModel.maxLength),
            ],
            maxLines: textInputModel.maxLine ? 1 : 2,
            style: TextStyle(color: AppColors.accentBlueColor()),
            keyboardType: textInputModel.keyboardType,
            controller: textInputModel.textEditingController,
            focusNode: textInputModel.focusNode,
            readOnly: readOnly,
            enabled: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onFieldSubmitted: (value) {
              if (textInputModel.onFieldSubmitted != null) {
                textInputModel.onFieldSubmitted!(value);
              }
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              hintText: textInputModel.hintText,
              hintStyle: const TextStyle(color: AppColors.basicGrey1),
              prefixIcon:
                  textInputModel.svgIconPath != null &&
                          textInputModel.isShowIcon
                      ? Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          textInputModel.svgIconPath!,
                          fit: BoxFit.scaleDown,
                          width: 24,
                          height: 24,
                          color: AppColors.title2(),
                        ),
                      )
                      : null,
              suffixIcon:
                  !textInputModel.isShowIcon
                      ? null
                      : textInputModel.isPassword
                      ? IconButton(
                        onPressed: () {
                          isObscure.toggle();
                        },
                        icon: Icon(
                          isObscure.value
                              ? Icons.visibility_off
                              : Icons.remove_red_eye,
                          color: AppColors.title2(),
                        ),
                      )
                      : (textInputModel.currentLength != null)
                      ? Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          '${textInputModel.currentLength!.value}/${textInputModel.maxLength}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      )
                      : null,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      textInputModel.ColorBoder
                          ? AppColors.bgBtnBlue()
                          : AppColors.title2(),
                  width: 1.0,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      textInputModel.ColorBoder
                          ? AppColors.bgBtnBlue()
                          : AppColors.title2(),
                  width: 1.0,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      textInputModel.ColorBoder
                          ? AppColors.bgBtnBlue()
                          : AppColors.title2(),
                  width: 1.0,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      textInputModel.ColorBoder
                          ? AppColors.bgBtnBlue()
                          : AppColors.title2(),
                  width: 1.0,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      textInputModel.ColorBoder
                          ? AppColors.bgBtnBlue()
                          : AppColors.title2(),
                  width: 1.0,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            obscureText: isObscure.value,
            onChanged: (value) {
              if (!textInputModel.isPassword &&
                  textInputModel.currentLength != null) {
                textInputModel.currentLength!.value =
                    textInputModel.textEditingController!.text.length;
              }
            },
            validator: (text) {
              return (textInputModel.isValidated ?? false)
                  ? FncUtils.validateField(
                    text,
                    isEmail: textInputModel.isEmail!,
                  )
                  : null;
            },
          ),
        ],
      ),
    );
  }

  static Widget baseBottomSheet({
    required String title,
    required Widget body,
    Widget? iconTitle,
    bool isSecondDisplay = false,
    TextAlign? textAlign,
    AlignmentGeometry? alignment,
    Widget? actionArrowBack,
    Color? backgroundColor,
  }) {
    return SafeArea(
      bottom: false,
      minimum: EdgeInsets.only(
        top: Get.mediaQuery.padding.top + (isSecondDisplay ? 100 : 20),
      ),
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title.tr,
                    textAlign: textAlign ?? TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.titleLarge!.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ).paddingOnly(left: AppDimens.paddingHuge),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child:
                      actionArrowBack ??
                      const CloseButton(color: AppColors.primaryColor),
                ),
                iconTitle ?? const SizedBox(),
              ],
            ).paddingSymmetric(vertical: AppDimens.paddingSmall),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }

  static Widget buildButtonIcon({
    required IconData icons,
    required Function func,
    required Color colors,
    required String title,
    double sizeIcon = 20,
    double radius = 30,
    double padding = 8.0,
    Color? textColor,
    Color? iconColor = AppColors.white,
    String? imgAsset,
  }) => baseOnAction(
    onTap: func,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: colors,
            borderRadius: BorderRadius.circular(radius),
          ),
          child:
              imgAsset != null
                  ? Image.asset(
                    imgAsset,
                    fit: BoxFit.cover,
                    height: sizeIcon,
                    width: sizeIcon,
                  )
                  : Icon(icons, color: iconColor, size: sizeIcon),
        ),
        if (title.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            title.tr,
            style: Get.theme.textTheme.titleSmall!.copyWith(
              color: textColor ?? AppColors.dsGray1,
              fontSize: 12,
            ),
          ),
        ],
      ],
    ),
  );

  static Widget buildCardBase({
    required Widget child,
    Color? colorBorder,
    Color? backgroundColor,
    BoxDecoration? decoration,
  }) => Container(
    decoration: BoxDecoration(
      color: backgroundColor ?? AppColors.white,
      borderRadius: const BorderRadius.all(Radius.circular(AppDimens.radius8)),
      border: Border.all(color: colorBorder ?? Colors.transparent),
    ),
    child: child,
  );

  static Widget buildCardShadowBase({
    required Widget child,
    BoxDecoration? decoration,
    Color? backgroundColor,
  }) => Container(
    decoration:
        decoration ??
        BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0.0, 2.0),
              blurRadius: AppDimens.radius20,
            ),
          ],
          color: backgroundColor ?? AppColors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(AppDimens.radius8),
          ),
        ),
    child: child,
  );

  /// Sử dụng để tránh trường hợp click liên tiếp khi thực hiện function
  static Widget baseOnAction({required Function onTap, required Widget child}) {
    return InkWell(
      onTap: () {
        DateTime now = DateTime.now();
        if (_dateTime == null ||
            now.difference(_dateTime ?? DateTime.now()) > 1.seconds ||
            onTap.hashCode != _oldFunc) {
          _dateTime = now;
          _oldFunc = onTap.hashCode;
          onTap();
        }
      },
      child: child,
    );
  }

  static Future<DateTime?> buildDateTimePicker({
    required DateTime dateTimeInit,
    DateTime? minTime,
    DateTime? maxTime,
  }) async {
    DateTime? newDateTime = await showRoundedDatePicker(
      context: Get.context!,
      height: 340,
      initialDate: dateTimeInit,
      firstDate: minTime ?? DateTime.utc(1960),
      lastDate: maxTime ?? DateTime.now(),
      // barrierDismissible: true,
      theme: ThemeData(
        primaryColor: AppColors.white,
        dialogBackgroundColor: AppColors.dateTimeColor,
        disabledColor: AppColors.dsGray3,
        focusColor: AppColors.primaryColor,
        textTheme: TextTheme(
          bodySmall: Get.textTheme.bodyLarge!.copyWith(
            color: AppColors.dsGray3,
          ),
          bodyMedium: Get.textTheme.bodyLarge,
        ),
        colorScheme: const ColorScheme.light(
          primary: AppColors.primaryColor, // Selected day bg color
        ),
      ),
      styleDatePicker: MaterialRoundedDatePickerStyle(
        // paddingMonthHeader: const EdgeInsets.all(AppDimens.paddingVerySmall),
        textStyleMonthYearHeader: Get.textTheme.bodyLarge,
        colorArrowNext: AppColors.dsGray3,
        colorArrowPrevious: AppColors.dsGray3,
        textStyleButtonNegative: Get.textTheme.bodyLarge!.copyWith(
          color: AppColors.dsGray3,
        ),
        textStyleButtonPositive: Get.textTheme.bodyLarge!.copyWith(
          color: AppColors.primaryColor,
        ),
        textStyleCurrentDayOnCalendar: Get.textTheme.bodyLarge!.copyWith(
          color: AppColors.primaryColor,
        ),
      ),
    );
    return newDateTime;
  }

  static Future<TimeOfDay?> buildTimePicker() async {
    final selectedTime24Hour = showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dialOnly,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    return selectedTime24Hour;
  }

  static Widget buildDropdown<T>({
    required List<T> items,
    required String Function(T) display,
    T? selectedItem,
    ValueChanged<T?>? onChanged,
    double height = 50,
    String? hintText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimens.radius8),
        ),
        border: Border.all(color: const Color(0xFFEBECED)),
      ),
      child: DropdownButtonHideUnderlineCustom(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.defaultPadding,
          ),
          child: DropdownButtonCustom<T>(
            dropdownColor: AppColors.white,
            isExpanded: true,
            items:
                items
                    .map(
                      (e) => DropdownMenuItemCustom<T>(
                        value: e,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppDimens.paddingVerySmall,
                          ),
                          child: buildText(
                            display(e),
                            style:
                                selectedItem == e
                                    ? AppTextStyle.font14Bo
                                    : AppTextStyle.font14Re,
                            maxLine: 2,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    )
                    .toList(),
            value: selectedItem,
            onChanged: onChanged,
            hint:
                hintText != null
                    ? buildText(
                      hintText,
                      style: AppTextStyle.font14Re,
                      maxLine: 2,
                      textAlign: TextAlign.start,
                    )
                    : null,
          ),
        ),
      ),
    );
  }

  static Widget buildText(
    String text, {
    FontWeight? fontWeight,
    TextAlign? textAlign,
    Color? textColor,
    int? maxLine,
    double? fontSize,
    TextStyle? style,
    double minFontSize = 12,
  }) {
    return AutoSizeText(
      text,
      textAlign: textAlign ?? TextAlign.center,
      style:
          style ??
          AppTextStyle.font12Re.copyWith(
            color: textColor ?? AppColors.defaultTextColor,
            fontWeight: fontWeight,
            overflow: TextOverflow.ellipsis,
            fontSize: fontSize ?? AppDimens.fontSmall(),
          ),
      maxLines: maxLine ?? 1,
      minFontSize: minFontSize,
    );
  }
}
