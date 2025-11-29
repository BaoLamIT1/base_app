import Flutter
import flutter_local_notifications
import UIKit
import LocalAuthentication
import SwiftUI


@main
@objc class AppDelegate: FlutterAppDelegate {
    private let channelName = "vn.LamBaoBao/baseApp_channel"
    private let getBiometricType = "getBiometricType"
    private let getStatusBiometric = "getStatusBiometricIOS"


    override func application(
           _ application: UIApplication,
           didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
       ) -> Bool {

           let controller = window?.rootViewController as! FlutterViewController
           let methodChannel = FlutterMethodChannel(name: channelName, binaryMessenger: controller.binaryMessenger)

           methodChannel.setMethodCallHandler { (call, result) in
               Task { await self.handleMethodCall(call: call, result: result) }
           }
           GeneratedPluginRegistrant.register(with: self)

           return super.application(application, didFinishLaunchingWithOptions: launchOptions)
       }

    private func handleMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) async {
            let jsonStringArg = (call.arguments as? String) ?? ""
            let jsonData = jsonStringArg.data(using: .utf8) ?? Data()

                switch call.method {

                case getBiometricType:
                    result("\(self.biometricType)")
                    break
                case getStatusBiometric:
                    let context = LAContext()   /// đối tượng đại diện cho context của Local Authentication (FaceID / TouchId)
                    context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) // .canEvaluatePolicy : kiểm tra xem thiết bị có bật TouchID/FaceID chưa.
                    // .deviceOwnerAuthenticationWithBiometrics : policy cho xác thực bằng sinh trắc. Nếu không khả dụng (chưa setup FaceID, không có cảm biến) → return nil.
                    if let domainState = context.evaluatedPolicyDomainState {
                        // Data blob do hệ thống cung cấp.
                        let bData = domainState.base64EncodedData()
                        if let decodedString = String(data: bData, encoding: .utf8) {
                            result("\(decodedString)")   // App chỉ cần lưu string này lần đầu. Lần sau so sánh → nếu khác nhau thì biết là user đã thay đổi vân tay/FaceID.
                        }
                    } else {
                        result("")
                    }
                    break

                default:
                    result(FlutterMethodNotImplemented)
                }

        }

    enum BiometricType: String {
           case none = ""
           case touchID = "TouchID"
           case faceID = "FaceID"
       }

       var biometricType: BiometricType {
           let context = LAContext()
           var error: NSError?

           let canEval = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)

           if #available(iOS 11.0, *) {
               // Nếu không đánh giá được (biometry tắt, chưa đăng ký, không khả dụng) → none
               guard canEval else { return .none }
               switch context.biometryType {
               case .none:
                   return .none
               case .touchID:
                   return .touchID
               case .faceID:
                   return .faceID
               case .opticID:
                   return .none
               @unknown default:
                   return .none
               }
           } else {
               // iOS < 11 chỉ có Touch ID
               return canEval ? .touchID : .none
           }
       }

}
