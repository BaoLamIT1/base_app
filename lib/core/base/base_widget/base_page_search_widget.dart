import 'package:flutter/material.dart';

import '../../utils/widgets/keyboard.dart';
import '../base_controller/base_page_search_controller.dart';
import 'base_refresh_widget.dart';

abstract class BasePageSearchWidget<T extends BasePageSearchController>
    extends BaseRefreshWidget<T> {
  const BasePageSearchWidget({super.key});

  /// Widget cài đặt appbar có thể scroll.
  ///
  ///  `listSLiverAppBar`, danh sách sliverappbar.
  ///
  ///  `widgetBody` widget chính của page dưới appbar.
  Widget buildAppBarScroll({
    required List<Widget> listSliverAppBar,
    required Widget widgetBody,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (_) {
        KeyBoard.hide();
      },
      child: NestedScrollView(
        physics: const PageScrollPhysics(),
        controller: controller.scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return listSliverAppBar;
        },
        body: widgetBody,
      ),
    );
  }

  Widget widgetItemList(int index);
}
