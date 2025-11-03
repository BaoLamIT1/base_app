# To generate a localization file:

- Chạy câu này lần đầu để activate get_cli

dart pub global activate get_cli

- Khi thay đổi string trong file json thì chạy câu này
  get generate locales assets/locales
- Khi thêm mới icon:
  fvm flutter pub run build_runner build
- Khi đổi icon cho app:
  - Android: 
    Thêm ảnh vào android/app/src/main/res
    Thêm native code vào android/app/src/main/kotlin/.../MainActivity.kt
    Thêm vào AndroidManifest.xml
    Thêm vào 
  - IOS:
   Thêm ảnh vào ios/Runner/Assets.xcassets/AppIcon.appiconset
   Thêm vào Info.plist