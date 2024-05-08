package com.blackmonk13.text_scanner

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "app.channel.shared.data"
    private var sharedText: String? = null
    private var sharedImageUri: Uri? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Handle the intent if the app was opened from the share menu
        handleSendIntent(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        // Handle the intent if the app was already running and it's brought to the foreground
        handleSendIntent(intent)
    }

    private fun handleSendIntent(intent: Intent) {
        when (intent.action) {
            Intent.ACTION_SEND -> {
                if ("text/plain" == intent.type) {
                    sharedText = intent.getStringExtra(Intent.EXTRA_TEXT)
                } else if (intent.type?.startsWith("image/") == true) {
                    sharedImageUri = intent.getParcelableExtra(Intent.EXTRA_STREAM) as? Uri
                }
            }
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getSharedText") {
                result.success(sharedText)
                sharedText = null
            } else if (call.method == "getSharedImageUri") {
                result.success(sharedImageUri.toString())
                sharedImageUri = null
            }
        }
    }
}
