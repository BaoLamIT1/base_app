package com.example.base_app

import android.os.Build
import android.security.keystore.*
import java.security.*
import javax.crypto.*
// Quản lý Cipher và Key trong Android KeyStore để xác thực sinh trắc học
object BiometricManagerHelper {

    @Throws(NoSuchPaddingException::class, NoSuchAlgorithmException::class)
    // Tạo Cipher để mã hoá/ giải mã dữ liệu sử dụng mã hoá AES
    fun getCipher(): Cipher {
        return Cipher.getInstance(
            "${KeyProperties.KEY_ALGORITHM_AES}/" +
                    "${KeyProperties.BLOCK_MODE_CBC}/" +
                    "${KeyProperties.ENCRYPTION_PADDING_PKCS7}"
        )
    }

    @Throws(KeyStoreException::class, NoSuchAlgorithmException::class, UnrecoverableKeyException::class)
    // Lấy SecretKey lưu trong Android KeyStore ( Provider lưu Key bên trong, tránh lưu raw key vào RAM)
    fun getSecretKey(keyName: String): SecretKey? {
        val keyStore = KeyStore.getInstance("AndroidKeyStore").apply { load(null) }
        return keyStore.getKey(keyName, null) as? SecretKey
    }
    // Generate Secret Key : sinh khoá mới lưu vào Android KeyStore
    fun generateSecretKey(keyName: String) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val keyGenerator = KeyGenerator.getInstance(
                KeyProperties.KEY_ALGORITHM_AES, "AndroidKeyStore"
            )
            val spec = KeyGenParameterSpec.Builder(
                keyName,
                KeyProperties.PURPOSE_ENCRYPT or KeyProperties.PURPOSE_DECRYPT
            )
                .setBlockModes(KeyProperties.BLOCK_MODE_CBC)
                .setEncryptionPaddings(KeyProperties.ENCRYPTION_PADDING_PKCS7)
                .setUserAuthenticationRequired(true) // Set key sau khi user xác thực sinh trắc
                .setInvalidatedByBiometricEnrollment(true) // Khi thay đổi biometric invalidated key cũ
                .build()

            keyGenerator.init(spec)
            keyGenerator.generateKey() // Sinh key mới và lưu vào AndroidKeyStore
        }
    }
    // Reset Secret Key khi biometric thay đổi, delete key cũ và tạo key mới
    fun resetSecretKey(keyName: String): Boolean {
        return try {
            val ks = KeyStore.getInstance("AndroidKeyStore")
            ks.load(null)
            if (ks.containsAlias(keyName)) {  // Kiểm tra Key còn tồn tại hay k
                ks.deleteEntry(keyName)     // Xoá Key khỏi KeyStore
            }
            generateSecretKey(keyName)          // Tạo Key mới
            true
        } catch (e: Exception) {
            e.printStackTrace()
            false
        }
    }
}
