package com.example.base_app

import android.content.ComponentName
import android.content.pm.PackageManager
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "app.icon.switcher"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
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

        // Enable alias được chọn
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
