import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TextInputModel {
  String? svgIconPath; // 👈 Thay vì IconData
  String? hintText;
  TextEditingController? textEditingController;
  FocusNode? focusNode;
  RxInt? currentLength;
  int? maxLength;
  int? size;
  bool? isEmail;
  bool isPassword;
  bool? isValidated;
  bool isShowIcon;
  bool ColorBoder;
  bool colorHintext;
  bool readOnly;
  bool maxLine;
  TextInputType? keyboardType;
  void Function(String)? onFieldSubmitted;

  TextInputModel({
    this.svgIconPath,
    this.hintText,
    this.textEditingController,
    this.focusNode,
    this.currentLength,
    this.maxLength,
    this.size,
    this.isEmail = false,
    this.isPassword = false,
    this.keyboardType,
    this.isValidated = false,
    this.isShowIcon = true,
    this.ColorBoder = true,
    this.readOnly = true,
    this.colorHintext = true,
    this.maxLine = true,
    this.onFieldSubmitted,
  });
}
