import 'package:base_app/core/base/base_controller/base_controller.dart';
import 'package:base_app/feature/home/controller/settings_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const _defaultPageIndex = 0;

class PageBuilderController extends BaseGetxController
    with PopScopeCtrlMixin<void>, GetSingleTickerProviderStateMixin {
  final pageIndex = RxInt(_defaultPageIndex);
  late final tabCtrl = TabController(length: 4, vsync: this);

  @override
  void onInit() {
    super.onInit();
  }

  void changePage(int index) {
    pageIndex.value = index;
    tabCtrl.animateTo(index); // chuyển tab
  }

  @override
  bool get didPop => tabCtrl.index == _defaultPageIndex;

  @override
  void onPopInvoked(bool didPop, void result) {
    tabCtrl.animateTo(_defaultPageIndex);
  }

  @override
  void onReady() {
    super.onReady();
    tabCtrl.addListener(() {
      pageIndex.value = tabCtrl.index; // đồng bộ tab <-> bottom nav
      canPop.value = didPop;
    });
  }

  @override
  void onClose() {
    tabCtrl.dispose();
    super.onClose();
  }
}
