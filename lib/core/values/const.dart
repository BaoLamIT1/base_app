/// class chứa các giá trị không đổi quan trọng trong dự án
class AppConst {

  //app
  static const String appName = "clinical";

  // static const String playStoreName = "vn.lambaobao.clinical";

  //base
  static const int pageSize = 10;
  static const int defaultPage = 1;
  static const Duration requestTimeOut = Duration(seconds: 20);

  static const int millisecondsDefault = 1000;
  static const int limitPhone = 10;
  static const int responseSuccess = 2;
  static const int codeSuccess = 200;
  static const int statusSuccess = 0;
  static const int currencyUtilsMaxLength = 12;

  //
  static const int currentStepMax = 5;

  //
  static const int perPageNotification = 20;
  static const int pageIndex0 = 0;
  static const int pageIndex1 = 1;

  ///language code
  static const String keyLocale = "keyLocale";
  static const String countryCodeVN = "VN";
  static const String countryCodeEN = "EN";
  static const String languageCodeVN = "vi";
  static const String languageCodeEN = "en";
  static const String countryCode = "countryCode";

  //error
  static const int error500 = 500;
  static const int error404 = 404;
  static const int error405 = 405;
  static const int error401 = 401;
  static const int error403 = 403;
  static const int error400 = 400; // OTP is invalid or expired
  static const int error502 = 502;
  static const int error503 = 503;

  static const String invoiceSeparator = " | ";
  static const String vnd = "VNĐ";
  static const String millionSort = 'tr';
  static const String billion = 'tỷ';
  static const String moneySpaceStr = ",";
  static const int moneySpacePos = 3;

  ///giá trị mặc định phần nghìn
  static const bool isDot = false;

  ///action snackbar
  static const String actionSuccess = "actionSuccess";
  static const String actionFail = "actionFail";
  static const String actionNotification = "actionNotification";
  static const String actionWarning = "actionWarning";
}
