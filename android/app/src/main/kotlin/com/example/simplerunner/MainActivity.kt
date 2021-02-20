package com.example.simplerunner

import android.content.Intent
import android.os.Build
import android.os.Bundle
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private lateinit var runningPerformanceBackgroundServiceIntent: Intent

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Notifications.createNotificationChannels(this)
        runningPerformanceBackgroundServiceIntent =  Intent(this, RunningPerformanceBackgroundService::class.java)
    }

    override fun onDestroy() {
        stopService(runningPerformanceBackgroundServiceIntent)
        super.onDestroy()
    }

    @RequiresApi(Build.VERSION_CODES.O)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val binaryMessenger = flutterEngine.dartExecutor.binaryMessenger

        MethodChannel(binaryMessenger, "com.example.simplerunner/app_retain").apply {
            setMethodCallHandler { method, result ->
                when (method.method) {
                    "startService" -> {
                        startForegroundService(runningPerformanceBackgroundServiceIntent)
                        result.success(null)
                    }
                    "stopService" -> {
                        stopService(runningPerformanceBackgroundServiceIntent)
                        result.success(null)
                    }
                    "sendToBackground" -> {
                        moveTaskToBack(true)
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
        }
    }
}

