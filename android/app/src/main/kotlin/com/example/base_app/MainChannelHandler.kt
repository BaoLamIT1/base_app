package com.example.base_app

import android.os.Build
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import javax.crypto.Cipher
import javax.crypto.SecretKey
import android.security.keystore.KeyPermanentlyInvalidatedException
import java.security.InvalidKeyException

object MainChannelHandler {

    private const val GET_STATUS_BIOMETRIC_ANDROID = "getStatusBiometricAndroid"
    private const val RESET_BIOMETRIC_ANDROID = "resetBiometricAndroid"

    fun handleMethodCall(
        activity: MainActivity,
        call: MethodCall,
        result: MethodChannel.Result,
        keyName: String
    ) {
        when (call.method) {
            GET_STATUS_BIOMETRIC_ANDROID -> {
                var cipher: Cipher? = null
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    try {
                        cipher = BiometricManagerHelper.getCipher()
                    } catch (e: Exception) {
                        e.printStackTrace()
                    }
                }

                var secretKey: SecretKey? = null
                try {
                    secretKey = BiometricManagerHelper.getSecretKey(keyName)
                } catch (e: Exception) {
                    e.printStackTrace()
                }

                if (secretKey == null && Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    BiometricManagerHelper.generateSecretKey(keyName)
                }

                try {
                    cipher?.init(Cipher.ENCRYPT_MODE, secretKey)
                    result.success(false)
                } catch (e: KeyPermanentlyInvalidatedException) {
                    result.success(true)
                } catch (e: InvalidKeyException) {
                    result.success(true)
                    e.printStackTrace()
                }
            }

            RESET_BIOMETRIC_ANDROID -> {
                val success = BiometricManagerHelper.resetSecretKey(keyName)
                result.success(success)
            }
        }
    }
}
