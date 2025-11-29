package com.example.base_app

import android.content.Context
import androidx.biometric.BiometricPrompt
import java.nio.charset.Charset
import java.util.concurrent.Executor

object BiometricInitHelper {
    private var biometricPrompt: BiometricPrompt? = null

    fun initPrompt(context: Context, executor: Executor) {
        biometricPrompt = BiometricPrompt(
            (context as androidx.fragment.app.FragmentActivity),
            executor,
            object : BiometricPrompt.AuthenticationCallback() {
                // Xử lý các lỗi: terminate, cancle biometric, time-out, k có cảm biến, biometric bị disabled.
                // Sau khi gọi thì BiometricPrompt đóng, khi xác thực gọi authenticate() lại
                override fun onAuthenticationError(
                    errorCode: Int,
                    errString: CharSequence
                ) {
                    super.onAuthenticationError(errorCode, errString)
                }
                // Xử lý authenticate thành công
                override fun onAuthenticationSucceeded(
                    result: BiometricPrompt.AuthenticationResult
                ) {
                    try {
                        result.cryptoObject?.cipher?.doFinal(
                            "ok".toByteArray(Charset.defaultCharset())
                        )
                    } catch (e: Exception) {
                        e.printStackTrace()
                    }
                }
                // Xử lý khi xác thực sinh trắc học k khớp
                override fun onAuthenticationFailed() {
                    super.onAuthenticationFailed()
                }
            }
        )
    }

    fun getPrompt(): BiometricPrompt? = biometricPrompt
}
