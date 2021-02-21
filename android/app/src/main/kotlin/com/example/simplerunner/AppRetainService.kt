package com.example.simplerunner

import android.app.Service
import android.content.Intent
import android.os.IBinder

class AppRetainService : Service() {
    override fun onCreate() {
        super.onCreate()
        val notification = Notifications.buildForegroundNotification(this)
        startForeground(Notifications.NOTIFICATION_ID_BACKGROUND_SERVICE, notification)
    }

    override fun onBind(intent: Intent): IBinder? = null
}