import 'package:base_app/core/base/base_src.dart';
import 'package:base_app/feature/change_icon/change_icon_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeAppIconScreen extends BaseGetWidget<ChangeIconController> {
  const ChangeAppIconScreen({super.key});

  @override
  ChangeIconController get controller => Get.put(ChangeIconController());

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đổi biểu tượng ứng dụng'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.icons.length,
        itemBuilder: (context, index) {
          final icon = controller.icons[index];
          final selected = icon.alias == controller.currentIcon;
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Image.asset(icon.asset, width: 48, height: 48),
              title: Text(icon.name),
              trailing:
                  selected
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : controller.isLoading
                      ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                      : null,
              onTap:
                  controller.isLoading
                      ? null
                      : () {
                        if (!selected) controller.changeIcon(icon.alias);
                      },
            ),
          );
        },
      ),
    );
  }
}
