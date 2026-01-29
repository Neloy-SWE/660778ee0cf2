package neloy.swe.system_metrics_mobile_app

import android.annotation.SuppressLint
import android.app.ActivityManager
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import android.os.PowerManager
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channel = "getSystemMetrics"

    @SuppressLint("HardwareIds")
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, channel
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "getAndroidId"-> {
                    val androidId = Settings.Secure.getString(
                        contentResolver,
                        Settings.Secure.ANDROID_ID
                    )
                    result.success(androidId)
                }
                "metricsThermal" -> {
                    val thermalLevel = getThermalLevel()
                    val thermalStatus = getThermalStatus(thermalLevel)

                    result.success(
                        mapOf(
                            "thermalLevel" to thermalLevel, "thermalStatus" to thermalStatus
                        )
                    )
                }
                "metricsBattery" -> {
                    val batteryLevel = getBatteryLevel()
                    result.success(
                        mapOf(
                            "batteryLevel" to batteryLevel
                        )
                    )
                }
                "metricsMemory" -> {
                    val memoryUsage = getMemoryUsage()
                    result.success(
                        mapOf(
                            "memoryUsage" to memoryUsage
                        )
                    )
                }
                /*"metricsStorage" -> {
                    val storageUsage = getStorageUsage()
                    result.success(
                        mapOf(
                            "storageUsage" to storageUsage
                        )
                    )
                }*/
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun getThermalLevel(): Int {
        val powerManager = getSystemService(Context.POWER_SERVICE) as PowerManager

        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            powerManager.currentThermalStatus
        } else {
            val intent = registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            val temp = intent?.getIntExtra(BatteryManager.EXTRA_TEMPERATURE, 0) ?: 0
            when {
                temp <= 350 -> 0
                temp <= 400 -> 1
                temp <= 450 -> 2
                else -> 3
            }
        }
    }

    private fun getThermalStatus(level: Int): String {
        return when (level) {
            0 -> "Normal"
            1 -> "light"
            2 -> "Moderate"
            3 -> "Severe"
            else -> "Critical"
        }
    }

    private fun getBatteryLevel(): Int {
        val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }

    private fun getMemoryUsage(): Double {
        val activityManager = getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        val memoryInfo = ActivityManager.MemoryInfo()
        activityManager.getMemoryInfo(memoryInfo)

        val usedMemory = memoryInfo.totalMem - memoryInfo.availMem
        return (usedMemory.toDouble() / memoryInfo.totalMem.toDouble()) * 100
    }

//    private fun getStorageUsage(): Double {
//        val path = Environment.getDataDirectory()
//        val stat = StatFs(path.path)
//        val totalBytes = stat.totalBytes
//        val availableBytes = stat.availableBytes
//
//        val usedBytes = totalBytes - availableBytes
//
//        return if (totalBytes > 0) {
//            (usedBytes.toDouble() / totalBytes.toDouble()) * 100
//        } else {
//            0.0
//        }
//    }
}
