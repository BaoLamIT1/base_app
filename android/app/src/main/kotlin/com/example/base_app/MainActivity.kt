package com.example.base_app

// Flutter
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

// Android
import android.content.ComponentName
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import androidx.core.content.ContextCompat
import androidx.biometric.BiometricPrompt

// Executor
import java.util.concurrent.Executor

class MainActivity : FlutterFragmentActivity() {

    // Biometric
    private lateinit var executor: Executor
    private var channelResult: MethodChannel.Result? = null

    companion object {
        const val CHANNEL = "vn.LamBaoBao/baseApp_channel"
        const val ICON_CHANNEL = "app.icon.switcher"

        const val KEY_NAME = "baseApp"
        private const val GET_STATUS_BIOMETRIC_ANDROID = "getStatusBiometricAndroid"
        private const val RESET_BIOMETRIC_ANDROID = "resetBiometricAndroid"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        executor = ContextCompat.getMainExecutor(this)

        // Init Biometric
        BiometricInitHelper.initPrompt(this, executor)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        //
        // 1️⃣ CHANNEL BIOMETRIC
        //
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            channelResult = result
            MainChannelHandler.handleMethodCall(
                this,
                call,
                result,
                KEY_NAME
            )
        }

        //
        // 2️⃣ CHANNEL CHANGE APP ICON
        //
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            ICON_CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "changeIcon" -> {
                    val alias = call.argument<String>("alias")
                    changeIcon(alias)
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }
    }

    //
    // ⭐ Hàm đổi icon
    //
    private fun changeIcon(aliasName: String?) {
        val pm = applicationContext.packageManager
        val packageName = applicationContext.packageName

        val aliases = listOf(
            "$packageName.MainActivityAlias1",
            "$packageName.MainActivityAlias2",
            "$packageName.MainActivityCRM",
            "$packageName.MainActivityHRM",
        )

        // Disable tất cả alias
        for (name in aliases) {
            pm.setComponentEnabledSetting(
                ComponentName(packageName, name),
                PackageManager.COMPONENT_ENABLED_STATE_DISABLED,
                PackageManager.DONT_KILL_APP
            )
        }

        // Enable đúng alias
        aliasName?.let {
            val target = "$packageName.$it"

            pm.setComponentEnabledSetting(
                ComponentName(packageName, target),
                PackageManager.COMPONENT_ENABLED_STATE_ENABLED,
                PackageManager.DONT_KILL_APP
            )
        }
    }
}