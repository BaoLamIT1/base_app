part of 'liveness_result_page.dart';

Widget _buildBody(LivenessResultController controller) {
  return Form(
    key: controller.formKey,
    child: Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.padding16,
              vertical: AppDimens.padding16,
            ),
            child: Column(
              children: [
                _buildImage(controller),
                sdsSBHeight16,
                _buildInput(controller),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInput(LivenessResultController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextUtils(
        text: LocaleKeys.app_fullName1.tr,
        availableStyle: StyleEnum.NunitoInput,
        color: AppColors.basicGrey1,
      ),
      const SizedBox(height: AppDimens.padding4),
      UtilWidgets.buildInput(
          TextInputModel(
              hintText: LocaleKeys.app_EnterFullName1.tr,
              maxLength: 20,
              size: 12,
              isValidated: true,
              textEditingController: controller.fullNameController),
          readOnly: true),
      sdsSBHeight15,
      TextUtils(
        text: LocaleKeys.app_studentId.tr,
        availableStyle: StyleEnum.NunitoInput,
        color: AppColors.basicGrey1,
      ),
      const SizedBox(height: AppDimens.padding4),
      UtilWidgets.buildInput(
          TextInputModel(
              hintText: LocaleKeys.app_EnterStudentId.tr,
              maxLength: 20,
              size: 12,
              isValidated: true,
              textEditingController: controller.studentIdController),
          readOnly: true),
      sdsSBHeight15,
      TextUtils(
        text: LocaleKeys.app_classUnit.tr,
        availableStyle: StyleEnum.NunitoInput,
        color: AppColors.basicGrey1,
      ),
      const SizedBox(height: AppDimens.padding4),
      UtilWidgets.buildInput(
          TextInputModel(
              hintText: LocaleKeys.app_EnterClassUnit.tr,
              maxLength: 20,
              size: 12,
              isValidated: true,
              textEditingController: controller.classNameController),
          readOnly: true),
    ],
  );
}

Widget _buildFooter(LivenessResultController controller) {
  return Obx(
    () => Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.paddingSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: BaseButton.buildButton(
              LocaleKeys.app_retake.tr,
              () {
                controller
                    .navigateToLivenessInstruction(); // Chuyển về  instruct_liveness
              },
              colors: AppColors.colorBasicWhite,
              colorText: AppColors.primaryColor,
              isLoading: controller.isShowLoading.value,
              border: Border.all(
                color: AppColors.primaryColor,
                width: 1,
              ),
            ).paddingOnly(right: AppDimens.padding8),
          ),
          Expanded(
            child: BaseButton.buildButton(
              LocaleKeys.app_addNew.tr,
              () => controller.createFace(),
              colors: AppColors.colorBtnPrimaryBlue,
              isLoading: controller.isShowLoading.value,
            ).paddingOnly(left: AppDimens.padding8),
          ),
        ],
      ),
    ),
  );
}

Widget _buildImage(LivenessResultController controller) {
  MapEntry<LivenessStep, Uint8List>? neutralEntry;
  try {
    neutralEntry = controller.allImages.firstWhere(
      (entry) => entry.key == LivenessStep.neutral,
    );
  } catch (e) {
    neutralEntry = null;
  }
  final Uint8List neutralImage = neutralEntry?.value ?? Uint8List(0);
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      neutralImage.isNotEmpty
          ? Image.memory(
              neutralImage,
              width: 112.w,
              height: 150.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  Assets.images.imgIntructLiveness.path,
                  width: 112.w,
                  height: 150.h,
                  fit: BoxFit.cover,
                );
              },
            )
          : Image.asset(
              Assets.images.imgIntructLiveness.path,
              width: 112.w,
              height: 150.h,
              fit: BoxFit.cover,
            ),
    ],
  );
}
