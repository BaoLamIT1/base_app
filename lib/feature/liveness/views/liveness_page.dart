import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../core/base/base_widget/base_button.dart';
import '../../../core/base/base_widget/base_widget.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/dimens.dart';
import '../../../generated/locales.g.dart';
import '../collection/liveness_collection.dart';
import '../controller/liveness_controller.src.dart';

part 'liveness_widget.dart';

class LiveNessPage extends BaseGetWidget {
  const LiveNessPage({super.key});

  @override
  LivenessController get controller => Get.put(LivenessController());

  @override
  Widget buildWidgets(context) {
    return SafeArea(
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) {
            return;
          }

          controller.closePros();

          Get.back();
        },
        child: buildLoadingOverlay(
          () => bodyLive(controller),
          // colorIcon: AppColors.white,
        ),
      ),
    );
  }
}

class CustomShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Vẽ các khối màu vào canvas
    Paint paint = Paint();

    // Tạo một Path đại diện cho phần bên ngoài của hình tròn
    double radius = size.width / 2 - 30; // Bán kính của hình tròn
    Offset center = Offset(
      size.width / 2,
      size.height / 2,
    ); // Tâm của hình tròn
    Path clipPath =
        Path()
          ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
          ..addOval(Rect.fromCircle(center: center, radius: radius));
    clipPath.fillType = PathFillType.evenOdd;

    // Cắt bỏ phần bên trong của các khối theo hình tròn
    canvas.clipPath(clipPath);

    // Vẽ các khối màu đã được cắt bỏ

    // Vẽ khối màu 1
    paint.color = AppColors.black;
    canvas.drawRect(
      Rect.fromLTRB(0, 0, size.width * 0.5, size.height * 0.5),
      paint,
    );

    // Vẽ khối màu 2
    paint.color = AppColors.black;
    canvas.drawRect(
      Rect.fromLTRB(size.width * 0.5, 0, size.width, size.height * 0.5),
      paint,
    );

    // Vẽ khối màu 3
    paint.color = AppColors.black;
    canvas.drawRect(
      Rect.fromLTRB(0, size.height * 0.5, size.width * 0.5, size.height),
      paint,
    );

    // Vẽ khối màu 4
    paint.color = AppColors.black;
    canvas.drawRect(
      Rect.fromLTRB(
        size.width * 0.5,
        size.height * 0.5,
        size.width,
        size.height,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
