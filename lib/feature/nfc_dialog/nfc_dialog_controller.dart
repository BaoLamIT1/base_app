import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:asn1lib/asn1lib.dart';
import 'package:base_app/core/core.src.dart';
import 'package:dmrtd/dmrtd.dart';
import 'package:dmrtd/extensions.dart';
import 'package:dmrtd/src/proto/can_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/base/app_state_store/app_state_store.dart';
import '../../generated/locales.g.dart';
import '../nfc/model/nfc_mrtd_data.dart';
import '../nfc/model/nfc_request_model.dart';

class NfcDialogController extends BaseGetxController {
  final state = AppStateStore();

  String? idDocument;
  DateTime? dateOfBirth;
  DateTime? dateOfExpiry;
  Rx<NfcMRTDData>? mrtdData;
  SendNfcRequestModel sendNfcRequestModel = SendNfcRequestModel();
  RxBool readComplete = false.obs;
  final NfcProvider nfc = NfcProvider();
  final scrollController = ScrollController();
  RxBool isReading = false.obs;
  bool isCloseDialog = false;

  RxInt processQuantity = 0.obs;
  int maxProcess = 10;
  bool checkIdentityError = false;

  @override
  Future<void> onInit() async {
    if (GetPlatform.isAndroid) {
      await scanNFC();
    }

    super.onInit();
  }

  Future<void> scanNFC() async {
    // dataOcrModel = Get.arguments;
    setupData();
    // userModel = UserModel();
    await readMRTD();
    if (sendNfcRequestModel.number != null) {
      if (Get.isDialogOpen == true) {
        Get.back();
      }
      //
      // if (state.typeChangePassword == AppConst.typeForgotPasswordByNfc) {
      //   _funcToForgotPassword();
      //   return;
      // }

      // Get.toNamed(
      //   AppRoutes.routeNfcInformationUser,
      //   arguments: sendNfcRequestModel,
      // );
    } else {
      if (!isCloseDialog) {
        if (Get.isDialogOpen == true) {
          Get.back();
        }
        if (checkIdentityError) {
          showSnackBar(LocaleKeys.nfc_infoNfcError.tr);
          checkIdentityError = false;
          return;
        }
        showSnackBar(LocaleKeys.nfc_nfcError.tr);
      }
    }
    sendNfcRequestModel = SendNfcRequestModel();
  }

  Future<void> closeNfc() async {
    showLoading();
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
    isCloseDialog = true;
    await nfc.disconnect();
    isReading.value = false;
    hideLoading();
  }

  void setupData() {
    idDocument = '034203011802';
    try {
      if (state.authProfileRequestModel.identity != null) {
        if (state.authProfileRequestModel.identity!.length > 6) {
          idDocument = '034203011802';
        }
      }
    } catch (e) {
      idDocument = dateOfBirth = dateOfExpiry = null;
    }
    Logger().d(idDocument);
  }

  Future<void> readMRTD({bool isPace = true}) async {
    try {
      processQuantity.value = 0;
      await nfc.connect(
        timeout: const Duration(seconds: 10),
        iosAlertMessage: LocaleKeys.nfc_introduceScanNfc1.tr,
      );
      processQuantity.value = 2;
      isReading.value = true;
      final passport = Passport(nfc);
      // nfc.setIosAlertMessage(LocaleKeys.nfc_introduceScanNfc2.tr);
      final mrtdDataTemp = NfcMRTDData();
      // try {
      //   mrtdDataTemp.cardAccess = await passport.readEfCardAccess();
      // } on PassportError {
      //   //if (e.code != StatusWord.fileNotFound) rethrow;
      // }
      // nfc.setIosAlertMessage(LocaleKeys.nfc_introduceScanNfc3.tr);

      // try {
      //   mrtdDataTemp.cardSecurity = await passport.readEfCardSecurity();
      // } on PassportError {
      //   // if (e.code != StatusWord.fileNotFound) rethrow;
      // }
      // await nfc.setIosAlertMessage(LocaleKeys.nfc_introduceScanNfc4.tr);
      if (isPace) {
        final accessKey = CanKey(idDocument!.substring(6));
        final efCardAccessData = AppConst.keyAccessDataNFCIos.parseHex();

        EfCardAccess efCardAccess = EfCardAccess.fromBytes(efCardAccessData);
        //PACE session
        Logger().d(accessKey);
        Logger().d(efCardAccess);
        await passport.startSessionPACE(accessKey, efCardAccess);
      } else {
        final bacKeySeed = DBAKey(
          idDocument ?? "",
          dateOfBirth ?? DateTime.now(),
          dateOfExpiry ?? DateTime.now(),
        );
        await passport.startSession(bacKeySeed);
      }

      processQuantity.value = 4;
      await nfc.setIosAlertMessage(
        formatProgressMsg(LocaleKeys.nfc_introduceScanNfc2.tr, 20),
      );
      mrtdDataTemp.com = await passport.readEfCOM();

      if (mrtdDataTemp.com!.dgTags.contains(EfDG1.TAG)) {
        mrtdDataTemp.dg1 = await passport.readEfDG1();
      }
      if (mrtdDataTemp.com!.dgTags.contains(EfDG2.TAG)) {
        mrtdDataTemp.dg2 = await passport.readEfDG2();
      }

      await nfc.setIosAlertMessage(
        formatProgressMsg(LocaleKeys.nfc_introduceScanNfc3.tr, 40),
      );
      if (mrtdDataTemp.com!.dgTags.contains(EfDG13.TAG)) {
        mrtdDataTemp.dg13 = await passport.readEfDG13();
      }
      if (mrtdDataTemp.com!.dgTags.contains(EfDG14.TAG)) {
        mrtdDataTemp.dg14 = await passport.readEfDG14();
      }
      await nfc.setIosAlertMessage(
        formatProgressMsg(LocaleKeys.nfc_introduceScanNfc2.tr, 60),
      );

      if (mrtdDataTemp.com!.dgTags.contains(EfDG15.TAG)) {
        mrtdDataTemp.dg15 = await passport.readEfDG15();
        mrtdDataTemp.aaSig = await passport.activeAuthenticate(Uint8List(8));
      }

      processQuantity.value = 6;
      await nfc.setIosAlertMessage(
        formatProgressMsg(LocaleKeys.nfc_introduceScanNfc2.tr, 80),
      );
      mrtdDataTemp.sod = await passport.readEfSOD();
      mrtdData?.value = mrtdDataTemp;

      // sendNfcRequestModel.sessionId = hiveApp.get(AppKey.sessionId);
      sendNfcRequestModel.type = "ID";
      _getDgGlobal(mrtdDataTemp);
      sendNfcRequestModel.mrz = removeSpecialCharacters(
        utf8.decode(mrtdDataTemp.dg1!.toBytes(), allowMalformed: true),
      );

      ///conver Dg13 VNM
      String decodedString = utf8.decode(
        mrtdDataTemp.dg13!.toBytes(),
        allowMalformed: true,
      );
      String rawData = removeSpecialCharacters(decodedString);
      sendNfcRequestModel.raw = rawData;
      _getDg13VNM(mrtdDataTemp.dg13!.toBytes());
      await nfc.setIosAlertMessage(
        formatProgressMsg(LocaleKeys.nfc_introduceScanNfc4.tr, 100),
      );
      processQuantity.value = 10;
      await nfc.disconnect();
    } catch (e) {
      Logger().d("e $e");
      if (!isCloseDialog) {
        await nfc.disconnect(
          iosErrorMessage: LocaleKeys.nfc_introduceScanNfcError.tr,
        );
        // nfc.setIosAlertMessage("Lỗi quét NFC. Quý khách vui lòng thử lại !");
        processQuantity.value = 0;
        if (Get.isDialogOpen == true) {
          Get.back();
        }
        if (e.toString().contains('sw=6300') ||
            e.toString().contains('General authentication template (step 4)')) {
          checkIdentityError = true;
        }
      }
    } finally {
      // processQuantity.value = 0;
      isReading.value = false;
    }
  }

  void _getDgGlobal(NfcMRTDData mrtdDataTemp) {
    sendNfcRequestModel.number = mrtdDataTemp.dg1?.mrz.optionalData.substring(
      0,
      12,
    );
    sendNfcRequestModel.name =
        "${mrtdDataTemp.dg1?.mrz.lastName} ${mrtdDataTemp.dg1?.mrz.firstName}";
    sendNfcRequestModel.firstName = mrtdDataTemp.dg1?.mrz.firstName;
    sendNfcRequestModel.lastName = mrtdDataTemp.dg1?.mrz.lastName;
    sendNfcRequestModel.dob = mrtdDataTemp.dg1?.mrz.dateOfBirth.toString();
    sendNfcRequestModel.doe = mrtdDataTemp.dg1?.mrz.dateOfExpiry.toString();
    sendNfcRequestModel.sex = mrtdDataTemp.dg1?.mrz.gender;
    sendNfcRequestModel.nationality = mrtdDataTemp.dg1?.mrz.country;
    sendNfcRequestModel.mrz = removeSpecialCharacters(
      utf8.decode(mrtdDataTemp.dg1!.toBytes(), allowMalformed: true),
    );
    sendNfcRequestModel.file = mrtdDataTemp.dg2?.toBytes().base64().substring(
      112,
    );
    sendNfcRequestModel.aaSignature = mrtdDataTemp.dg14?.toBytes().base64();
    sendNfcRequestModel.aaPublicKey =
        mrtdDataTemp.dg15?.aaPublicKey.toBytes().base64();
    sendNfcRequestModel.keyAlg = mrtdDataTemp.dg15?.aaPublicKey.type.toString();
  }

  void _getDg13VNM(Uint8List byteDg13) {
    Uint8List encodedData = Uint8List.fromList(byteDg13);
    ASN1Parser parser = ASN1Parser(encodedData);
    ASN1Object asn1Object = parser.nextObject();
    if (asn1Object is ASN1Sequence) {
      ASN1Sequence sequence = asn1Object;
      String asn1Data = sequence.elements[0].toString();
      RegExp regex = RegExp(r'(UTF8String|PrintableString)\((.*?)\)');
      Iterable<Match> matches = regex.allMatches(asn1Data);
      List<String> listDg13 = [];
      for (Match match in matches) {
        // String stringType = match.group(1)??"";
        String value = match.group(2) ?? "";
        listDg13.add(value);
      }
      if (listDg13.length >= 15) {
        sendNfcRequestModel.numberVMN = listDg13[0];
        sendNfcRequestModel.nameVNM = listDg13[1];
        sendNfcRequestModel.dobVMN = listDg13[2];
        sendNfcRequestModel.sexVMN = listDg13[3];
        sendNfcRequestModel.nationalityVMN = listDg13[4];
        sendNfcRequestModel.nationVNM = listDg13[5];
        sendNfcRequestModel.religionVMN = listDg13[6];
        sendNfcRequestModel.homeTownVMN = listDg13[7];
        sendNfcRequestModel.residentVMN = listDg13[8];
        sendNfcRequestModel.identificationSignsVNM = listDg13[9];
        sendNfcRequestModel.registrationDateVMN = listDg13[10];
        sendNfcRequestModel.doeVMN = listDg13[11];
        sendNfcRequestModel.nameDadVMN = listDg13[12];
        sendNfcRequestModel.nameMomVMN = listDg13[13];
        if (listDg13.length == 16) {
          if (startsWithNumber(listDg13[14])) {
            sendNfcRequestModel.otherPaper = listDg13[14];
          } else {
            sendNfcRequestModel.nameCouple = listDg13[14];
          }
        } else if (listDg13.length == 17) {
          if (startsWithNumber(listDg13[15])) {
            sendNfcRequestModel.otherPaper = listDg13[15];
            sendNfcRequestModel.nameCouple = listDg13[14];
          } else {
            sendNfcRequestModel.otherPaper = listDg13[14];
            sendNfcRequestModel.nameCouple = listDg13[15];
          }
        }
      }
    }
  }

  bool startsWithNumber(String input) {
    if (input.isEmpty) {
      return false;
    }

    String firstChar = input.substring(0, 1);
    return int.tryParse(firstChar) != null;
  }

  String removeSpecialCharacters(String input) {
    return input.replaceAll(
      RegExp(
        r'[^\w\s\r\f\t,:/-áàảãạăắằẳẵặâấầẩẫậéèẻẽẹêếềểễệíìỉĩịóòỏõọôốồổỗộơớờởỡợúùủũụưứừửữựýỳỷỹỵÁÀẢÃẠĂẮẰẲẴẶÂẤẦẨẪẬÉÈẺẼẸÊẾỀỂỄỆÍÌỈĨỊÓÒỎÕỌÔỐỒỔỖỘƠỚỜỞỠỢÚÙỦŨỤƯỨỪỬỮỰÝỲỶỸỴđĐ]',
      ),
      '',
    );
  }

  // void _mapFormData() {
  //   state.nfcFormModel = NfcFormModel(
  //     cccd: sendNfcRequestModel.number ?? "",
  //     name: sendNfcRequestModel.nameVNM ?? "",
  //     permanentAddress: sendNfcRequestModel.residentVMN ?? "",
  //     homeTown: sendNfcRequestModel.homeTownVMN ?? "",
  //     phoneNumber: state.authProfileRequestModel.phoneNumber ?? "",
  //     email: state.authProfileRequestModel.email ?? "",
  //     dateOfBirth: sendNfcRequestModel.dobVMN ?? "",
  //     dateOfExpiration: sendNfcRequestModel.doeVMN ?? "",
  //     dateOfIssue: sendNfcRequestModel.registrationDateVMN ?? "",
  //     sex:
  //         sendNfcRequestModel.sexVMN == "Nam"
  //             ? LocaleKeys.nfcInformationUserPage_sexM.tr
  //             : LocaleKeys.nfcInformationUserPage_sexF.tr,
  //   );
  // }

  Future<void> getToQr() async {
    PermissionStatus permissionStatus = await checkPermission([
      Permission.camera,
    ]);
    switch (permissionStatus) {
      case PermissionStatus.granted:
        {
          // Get.toNamed(AppRoutes.routeQrScan);
        }
        break;
      case PermissionStatus.permanentlyDenied:
        ShowPopup.openAppSetting();
        break;
      default:
        return;
    }
  }

  Future<PermissionStatus> checkPermission(
    List<Permission> listPermission,
  ) async {
    PermissionStatus status = PermissionStatus.granted;
    Map<Permission, PermissionStatus> statuses = await listPermission.request();
    for (var value in statuses.values) {
      if (value == PermissionStatus.permanentlyDenied) {
        status = PermissionStatus.permanentlyDenied;
        break;
      }
      if (value == PermissionStatus.denied) {
        status = PermissionStatus.denied;
        break;
      }
      // if (value == PermissionStatus.undetermined) {
      //   status = PermissionStatus.undetermined;
      //   break;
      // }
    }
    return status;
  }

  // Future<void> _funcToForgotPassword() async {
  //   state.nfcRequestData = NfcRequestData.fromSendModel(sendNfcRequestModel);
  //   _mapFormData();
  //   if (sendNfcRequestModel.residentVMN != "") {
  //     showLoading();
  //     NfcRepository nfcRepository = NfcRepository(this);
  //     var response = await nfcRepository.sendNfcReceiveRepository(
  //       state.nfcRequestData,
  //       state.authProfileRequestModel.identity ?? "",
  //     );
  //     hideLoading();
  //     if (response.success == EnumStatusResponse.success) {
  //       Get.toNamed(
  //         AppRoutes.routeForgotPassword,
  //         parameters: {"sessionId": response.data},
  //       );
  //     } else {
  //       showSnackBar(response.message);
  //     }
  //   } else {
  //     state.sendNfcRequestGlobalModel = sendNfcRequestModel;
  //     await getToQr();
  //   }
  // }
}
