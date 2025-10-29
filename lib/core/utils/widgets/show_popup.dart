import 'package:auto_size_text/auto_size_text.dart';
import 'package:base_app/core/utils/widgets/size_box.dart';
import 'package:base_app/core/utils/widgets/util_widgets.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../generated/locales.g.dart';
import '../../values/colors.dart';
import '../../values/dimens.dart';
import '../../values/strings.dart';

class ShowPopup {
  static int _numDialog = 0;

  static void _showDialog(
    Widget dialog,
    bool isActiveBack, {
    bool barrierDismissible = false,
  }) {
    _numDialog++;
    Get.dialog(
      NavigatorPopHandler(
        onPop: () => onBackPress(isActiveBack),
        child: dialog,
      ),
      barrierDismissible: barrierDismissible,
    ).whenComplete(() => _numDialog--);
  }

  static Future<bool> onBackPress(bool isActiveBack) {
    return Future.value(isActiveBack);
  }

  static void dismissDialog() {
    if (_numDialog > 0) {
      Get.back();
    }
  }

  /// Hiển thị loading
  ///
  /// `isActiveBack` có cho phép back từ bàn phím Android khi loading hay không, default = true
  void showLoadingWave({bool isActiveBack = true}) {
    _showDialog(getLoadingWidget(), isActiveBack);
  }

  static Widget getLoadingWidget() {
    return const Center(child: CupertinoActivityIndicator());
  }

  static Widget _baseButton(
    Function? function,
    String text, {
    Color? colorText,
    Color? backgroundColor,
    // bool isBottomLeft = true,
    // bool isBottomRight = true,
  }) {
    return UtilWidgets.baseOnAction(
      onTap: () {
        dismissDialog();
        function?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.radius8),
          color: backgroundColor ?? AppColors.primaryColor,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: AppDimens.fontBig(),
            color: colorText ?? AppColors.white,
          ),
          textScaler: TextScaler.noScaling,
          maxLines: 1,
        ),
      ),
    );
  }

  static Widget buildConfirmButton(
    String text, {
    required Function? function,
    Color backgroundColor = AppColors.primaryColor,
    Color textColor = Colors.white,
  }) {
    return UtilWidgets.baseOnAction(
      onTap: () {
        dismissDialog();
        function?.call();
      },
      child: Container(
        height: AppDimens.btnMedium,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: UtilWidgets.buildTextScale(
          text,
          maxLines: 1,
          fontWeight: FontWeight.bold,
          fontSize: AppDimens.fontMedium(),
          textColor: textColor,
        ),
      ),
    );
  }

  static Widget buildCancelButton(
    String text, {
    required VoidCallback onPressed,
    Color borderColor = AppColors.primaryColor,
    Color textColor = AppColors.colorBlack,
  }) {
    return UtilWidgets.baseOnAction(
      onTap: () {
        dismissDialog();
        onPressed.call();
      },
      child: Container(
        height: AppDimens.btnMedium,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor, width: 1),
        ),
        alignment: Alignment.center,
        child: UtilWidgets.buildTextScale(
          text,
          maxLines: 1,
          fontSize: AppDimens.fontMedium(),
          fontWeight: FontWeight.bold,
          textColor: textColor,
        ),
      ),
    );
  }

  /// Hiển thị dialog thông báo với nội dung cần hiển thị
  ///
  /// `funtion` hành động khi bấm đóng
  ///
  /// `isActiveBack` có cho phép back từ bàn phím Android hay không, default = true
  ///
  /// `isChangeContext` default true: khi gọi func không close dialog hiện tại (khi chuyển sang màn mới thì dialog hiện tại sẽ tự đóng)
  static void showDialogNotification(
    String content, {
    bool isActiveBack = true,
    Function? function,
    String nameAction = AppStr.close,
  }) {
    _showDialog(
      Dialog(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radius8),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: const Icon(
                  Icons.notifications_none,
                  size: AppDimens.sizeDialogNotiIcon,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                constraints: const BoxConstraints(maxHeight: 200),
                child: SingleChildScrollView(
                  child: Text(
                    content,
                    style: TextStyle(fontSize: AppDimens.fontMedium()),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    textScaler: TextScaler.noScaling,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: _baseButton(
                  function,
                  nameAction.tr,
                  colorText: AppColors.colorBlueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
      isActiveBack,
    );
  }

  static void showDialogConfirm(
    String content, {
    required Function confirm,
    required String actionTitle,
    bool isActiveBack = true,
    String? title,
    String? exitTitle,
    Function? cancelFunc,
    bool isAutoCloseDialog = false,
  }) {
    _showDialog(
      Dialog(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: AppDimens.paddingDivider),
                child: AutoSizeText(
                  title ?? LocaleKeys.app_notification.tr,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimens.fontBig(),
                    color: AppColors.defaultTextColor,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.defaultPadding,
                  vertical: AppDimens.paddingDivider,
                ),
                constraints: const BoxConstraints(maxHeight: 200),
                child: SingleChildScrollView(
                  child: Text(
                    content.tr,
                    style: Get.textTheme.bodyMedium?.copyWith(
                      color: AppColors.defaultTextColor,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.defaultPadding,
                  vertical: 4,
                ),
                width: double.infinity,
                height: AppDimens.btnMedium,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: buildCancelButton(
                        onPressed: () {
                          cancelFunc?.call();
                        },
                        exitTitle ?? LocaleKeys.app_cancel.tr,
                        //  colorText: AppColors.hintTextColor()
                      ),
                    ),
                    UtilWidgets.sizedWidth16,
                    Expanded(
                      child: buildConfirmButton(
                        actionTitle.tr,
                        function: confirm,
                      ),
                    ),
                  ],
                ),
              ),
              UtilWidgets.sizedBox16,
            ],
          ),
        ),
      ),
      isActiveBack,
    );
  }

  static void showDialogConfirmOnly(
    String content, {
    required Function confirm,
    required String actionTitle,
    bool isActiveBack = true,
    String? title,
    String? exitTitle,
    Function? cancelFunc,
    bool isAutoCloseDialog = false,
  }) {
    _showDialog(
      Dialog(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: AppDimens.paddingDivider),
                child: AutoSizeText(
                  title ?? LocaleKeys.app_notification.tr,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimens.fontBig(),
                    color: AppColors.defaultTextColor,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.defaultPadding,
                  vertical: AppDimens.paddingDivider,
                ),
                constraints: const BoxConstraints(maxHeight: 200),
                child: SingleChildScrollView(
                  child: Text(
                    content.tr,
                    style: Get.textTheme.bodyMedium?.copyWith(
                      color: AppColors.defaultTextColor,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.defaultPadding,
                  vertical: 4,
                ),
                width: double.infinity,
                height: AppDimens.btnMedium,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: buildConfirmButton(
                        actionTitle.tr,
                        function: confirm,
                      ),
                    ),
                  ],
                ),
              ),
              sdsSBHeight16,
            ],
          ),
        ),
      ),
      isActiveBack,
    );
  }

  static void showDialogConfirmWidget({
    required Function confirm,
    required String actionTitle,
    bool isActiveBack = true,
    String title = AppStr.notification,
    String exitTitle = AppStr.cancel,
    Function? cancelFunc,
    bool isAutoCloseDialog = false,
    required Widget buildBody,
  }) {
    _showDialog(
      Dialog(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: AutoSizeText(
                  title.tr,
                  textScaleFactor: 1,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: AppDimens.fontBiggest(),
                    color: AppColors.dsGray1,
                  ),
                ),
              ),
              buildBody,
              const Divider(height: 1),
              SizedBox(
                width: double.infinity,
                height: AppDimens.btnMedium,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: _baseButton(
                        cancelFunc,
                        exitTitle.tr,
                        colorText: AppColors.dsGray3,
                        backgroundColor: AppColors.white,
                      ),
                    ),
                    const VerticalDivider(
                      width: 1,
                      color: AppColors.accentColor,
                    ),
                    Expanded(
                      child: _baseButton(
                        confirm,
                        actionTitle.tr,
                        colorText: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      isActiveBack,
    );
  }

  static void showDialogCustom(
    Widget child, {
    bool isActiveBack = true,
    Function? function,
    String nameAction = AppStr.close,
  }) {
    _showDialog(
      Dialog(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: const Icon(
                  Icons.notifications_none,
                  size: AppDimens.sizeDialogNotiIcon,
                  color: Colors.blueAccent,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                constraints: const BoxConstraints(maxHeight: 200),
                child: SingleChildScrollView(child: child),
              ),
              const Divider(height: 1),
              SizedBox(
                width: double.infinity,
                child: _baseButton(
                  function,
                  nameAction.tr,
                  colorText: AppColors.colorBlueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
      isActiveBack,
    );
  }

  static void showRawDialog({required Widget child, bool isActiveBack = true}) {
    _showDialog(
      Dialog(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: child,
      ),
      isActiveBack,
    );
  }
}
