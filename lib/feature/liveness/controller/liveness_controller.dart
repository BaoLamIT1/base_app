import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as img;
import 'package:permission_handler/permission_handler.dart';

import '../../../core/core.src.dart';
import '../../../generated/locales.g.dart';
import '../collection/liveness_collection.dart';
import '../painters/liveness_detector.dart';

class LivenessController extends BaseGetxController {
  final AppController appController = Get.find<AppController>();
  late CameraController cameraController;
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
      enableClassification: true,
    ),
  );
  late List<CameraDescription> cameras;
  RxBool cameraIsInitialize = false.obs;

  List<LivenessStep> stepsSequence =
      []; // List lưu trữ các bước liveness, sequence các bước sẽ thực hiện
  RxInt currentStep = 0.obs;
  final RxBool isShowResult = false.obs;
  bool isStreamingImage = false;
  bool detecting = false;
  bool delay = true;

  // Thay đổi lưu trữ ảnh với enum làm key
  List<MapEntry<LivenessStep, Uint8List>> imageLivenessList = [];

  ///đếm 3s đổi biến check để chạy frame mới
  bool completeFrame = false;
  RxList<bool> listResult = <bool>[].obs;
  LivenessStep? currentLivenessStep;
  String question = '';
  RxBool isAutoTakePhoto = false.obs;
  RxBool isFaceEmpty = false.obs;
  RxBool isManyFace = false.obs;
  RxBool isNotSmile = false.obs;
  int countImage = 0;
  Rx<Uint8List?> imageTemp = Rx<Uint8List?>(null);
  double eyeOpenRightOld = 1.0;
  double eyeOpenLeftOld = 1.0;

  // late LivenessRepository livenessRepository = LivenessRepository(this);

  @override
  Future<void> onInit() async {
    super.onInit();
    showLoadingOverlay();
    await initCamera();
    _randomListQuestion();
    hideLoadingOverlay();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(
      /// index 0 for back side camera
      /// index 1 for front side camera
      cameras[1],
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup:
          Platform.isAndroid
              ? ImageFormatGroup.nv21
              : ImageFormatGroup.bgra8888,
    );
    await cameraController.initialize().then((value) {}).catchError((error) {
      ShowPopup.showDialogConfirm(
        AppStr.errorDetail(error),
        confirm: _requestPermission,
        actionTitle: LocaleKeys.app_cameraInitializeError.tr,
      );
    });
    cameraIsInitialize.value = cameraController.value.isInitialized;
  }

  Future<void> _requestPermission() async {
    await Permission.camera.request().then((value) async {
      if (value != PermissionStatus.denied) {
        await initCamera();
      }
    });
  }

  @override
  Future<void> onClose() async {
    await closePros();
    super.onClose();
  }

  Future<void> startStreamPicture() async {
    if (!isStreamingImage) {
      isStreamingImage = true;
      cameraController.startImageStream((image) async {
        if (!detecting) {
          await _processImage(image);
        }
      });
    }
  }

  /// Xử lý khung hình và trả về kết quả hành động vào action
  Future<void> _processImage(CameraImage image) async {
    detecting = true;

    InputImage? inputImage = CameraImageConverter.inputImageFromCameraImage(
      image,
      cameras[1],
      cameraController,
    );
    if (inputImage != null) {
      final faces = await _faceDetector.processImage(inputImage);
      if (faces.isNotEmpty) {
        isManyFace.value = faces.length > 1;
        isFaceEmpty.value = false;
        if (currentStep.value == 0) {
          currentStep.value++;
          // Kiểm tra bounds trước khi truy cập
          if (currentStep.value <= stepsSequence.length) {
            currentLivenessStep = stepsSequence[currentStep.value - 1];
          }
        }
        // Kiểm tra bounds trước khi truy cập stepsSequence
        if (currentStep.value > 0 &&
            currentStep.value <= stepsSequence.length) {
          LivenessStep currentEnum = stepsSequence[currentStep.value - 1];

          question = LivenessDetector(
            faces,
            eyeOpenRightOld,
            eyeOpenLeftOld,
          ).liveNessByEnum(currentEnum);

          eyeOpenRightOld = faces[0].rightEyeOpenProbability ?? 0.0;
          eyeOpenLeftOld = faces[0].leftEyeOpenProbability ?? 0.0;

          // So sánh với expected question từ enum
          String expectedQuestion =
              LivenessCollection.questions[currentEnum] ?? '';
          if ((question.compareTo(expectedQuestion) == 0) &&
              (expectedQuestion.compareTo(LocaleKeys.app_between.tr) == 0)) {
            isNotSmile.value = (faces[0].smilingProbability ?? 0.0) > 0.6;
          }

          await _detachProcessImage(
            question,
            image,
            inputImage,
            faces[0].smilingProbability ?? 0.0,
            faces[0].leftEyeOpenProbability ?? 0.0,
            faces[0].rightEyeOpenProbability ?? 0.0,
          );
        } else if (currentStep.value > stepsSequence.length) {
          // Nếu đã hoàn thành tất cả steps, chuyển sang success
          await _livenessSuccess();
        }
      } else {
        isManyFace.value = false;
        isFaceEmpty.value = true;
        isNotSmile.value = false;
      }
      detecting = false;
    }
  }

  Future<void> _detachProcessImage(
    String question,
    CameraImage image,
    InputImage inputImage,
    double smiling,
    double eyeLeftProbability,
    double eyeRightProbability,
  ) async {
    if (currentStep.value > 0 && currentStep.value <= stepsSequence.length) {
      if (completeFrame) {
        listResult.add(true);
        isShowResult.value = true;
        await Future.delayed(const Duration(seconds: 1));
        _resetLoopValue();
        currentStep.value++;
        completeFrame = false;

        if (currentStep.value <= stepsSequence.length) {
          currentLivenessStep = stepsSequence[currentStep.value - 1];
        } else {
          // Đã hoàn thành tất cả steps
          await _livenessSuccess();
          return;
        }
      } else {
        // Delay tránh vào bước 1 hoàn thành luôn
        if (currentStep.value == 1 && delay) {
          await Future.delayed(const Duration(seconds: 1));
          delay = false;
        }

        // Lấy expected question từ enum với bounds checking
        if (currentStep.value <= stepsSequence.length) {
          LivenessStep currentEnum = stepsSequence[currentStep.value - 1];
          String expectedQuestion =
              LivenessCollection.questions[currentEnum] ?? '';

          if (question.compareTo(expectedQuestion) == 0) {
            if (question.compareTo(LocaleKeys.app_between.tr) == 0) {
              if (!isManyFace.value && !isNotSmile.value) {
                isNotSmile.value = false;
                await _isolateConvertImg(inputImage, currentEnum);
                completeFrame = true;
              }
            } else {
              isNotSmile.value = false;
              await _isolateConvertImg(inputImage, currentEnum);
              completeFrame = true;
            }
          }
        }
      }
    } else if (currentStep.value > stepsSequence.length) {
      // Đã vượt quá số steps, chuyển sang success
      await _livenessSuccess();
    }
  }

  Future<T> waitAtLeast<T>(Future<T> future, Duration minDuration) async {
    final results = await Future.wait([future, Future.delayed(minDuration)]);
    return results[0] as T;
  }

  ///gọi hàm này chụp lại ảnh khi xong bước với enum làm key
  Future<void> _isolateConvertImg(InputImage image, LivenessStep step) async {
    await compute(isolateProcessImage, image).then((value) async {
      // Chỉ lưu vào list với enum làm key
      imageLivenessList.add(MapEntry(step, value));
    });
  }

  static Uint8List isolateProcessImage(InputImage item) {
    img.Image convertedImage =
        Platform.isAndroid
            ? CameraImageConverter.decodeYUV420SP(item)
            : img.Image.fromBytes(
              width: item.metadata!.size.width.toInt(),
              height: item.metadata!.size.height.toInt(),
              bytes: item.bytes!.buffer, // For iOS
              order: img.ChannelOrder.bgra,
            );

    // Xử lý hướng xoay ảnh và giảm size
    if (item.metadata!.size.width.toInt() >
        item.metadata!.size.height.toInt()) {
      convertedImage = img.copyRotate(convertedImage, angle: -90);
      convertedImage = img.copyResize(convertedImage, width: 320, height: 426);
    }

    //Giảm chất lượng ảnh
    final compressedBytes = img.encodeJpg(convertedImage, quality: 50);

    return Uint8List.fromList(compressedBytes);
  }

  void _randomListQuestion() {
    stepsSequence.clear();

    // Tạo copy của tất cả available steps để random
    List<LivenessStep> tempAvailableSteps = List.from(LivenessStep.values);

    for (int i = 0; i < AppConst.currentStepMax; i++) {
      if (tempAvailableSteps.isEmpty) break;

      var rng = Random();
      int randomIndex = rng.nextInt(tempAvailableSteps.length);
      LivenessStep selectedStep = tempAvailableSteps[randomIndex];

      // Kiểm tra logic tránh trùng lặp smile và eyeBlink
      if (selectedStep == LivenessStep.smile ||
          selectedStep == LivenessStep.eyeBlink) {
        bool hasSmileOrBlink = stepsSequence.any(
          (step) => step == LivenessStep.smile || step == LivenessStep.eyeBlink,
        );
        if (hasSmileOrBlink) {
          tempAvailableSteps.removeAt(randomIndex);
          if (tempAvailableSteps.isNotEmpty) {
            randomIndex = rng.nextInt(tempAvailableSteps.length);
            selectedStep = tempAvailableSteps[randomIndex];
          } else {
            break;
          }
        }
      }

      // Thêm vào sequence
      stepsSequence.add(selectedStep);
      tempAvailableSteps.removeAt(randomIndex);
    }

    // Set step đầu tiên
    if (stepsSequence.isNotEmpty) {
      currentLivenessStep = stepsSequence[0];
    }
  }

  Future<void> _livenessSuccess() async {
    cameraController.pausePreview();
    isManyFace.value = false;
    isFaceEmpty.value = false;
    showLoadingOverlay();
    await _completeResult();
  }

  /// Khởi tạo lại tham số cho câu hỏi tiếp theo
  void _resetLoopValue() {
    isShowResult.value = false;
  }

  Future<void> _completeResult() async {
    if (isStreamingImage) {
      Get.offAndToNamed(
        AppRoutes.routeLivenessResult,
        arguments:
            imageLivenessList, //  truyền List<MapEntry<LivenessStep, Uint8List>>
      );
    }
    isStreamingImage = false;
  }

  Future<void> closePros() async {
    if (cameraController.value.isStreamingImages) {
      await cameraController.stopImageStream();
    }
    cameraIsInitialize.value = false;
    await _faceDetector.close();
  }

  @override
  void dispose() async {
    super.dispose();
    cameraController.dispose();
  }
}
