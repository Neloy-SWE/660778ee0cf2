import Flutter
import UIKit
import Darwin

@main
@objc class AppDelegate: FlutterAppDelegate {
private let channelName = "getSystemMetrics"
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(
            name: channelName,
            binaryMessenger: controller.binaryMessenger
        )
      
      channel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            switch call.method {
            case "getIosId":
                result(UIDevice.current.identifierForVendor?.uuidString ?? "Unknown")
                
            case "metricsThermal":
                let level = self.getThermalLevel()
                let status = self.getThermalStatus(level: level)
                result([
                  "thermalLevel": level,
                  "thermalStatus": status
                ])
                
            case "metricsBattery":
                result(["batteryLevel": self.getBatteryLevel()])
                
                
            case "metricsMemory":
                result([
                  "memoryUsage": self.getMemoryUsage()
                ])
        
            default:
              result(FlutterMethodNotImplemented)
            }
          })
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func getBatteryLevel() ->Int{
      let device = UIDevice.current
      device.isBatteryMonitoringEnabled = true
      if device.batteryState == UIDevice.BatteryState.unknown {
          return -1
      } else {
          return Int(device.batteryLevel * 100)
      }
    }
    
    private func getThermalLevel() -> Int {
          return ProcessInfo.processInfo.thermalState.rawValue
      }

      private func getThermalStatus(level: Int) -> String {
          switch level {
          case 0: return "Normal"
          case 1: return "light"
          case 2: return "Moderate"
          case 3: return "Severe"
          default: return "Critical"
          }
      }
    

    private func getMemoryUsage() -> Double {
            var info = mach_task_basic_info()
            var count = mach_msg_type_number_t(
                MemoryLayout<mach_task_basic_info>.size / MemoryLayout<natural_t>.size
            )

            let kerr = withUnsafeMutablePointer(to: &info) {
                $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                    task_info(
                        mach_task_self_,
                        task_flavor_t(MACH_TASK_BASIC_INFO),
                        $0,
                        &count
                    )
                }
            }

            if kerr != KERN_SUCCESS {
                return 0.0
            }

            let usedMemory = Double(info.resident_size)
            let totalMemory = Double(ProcessInfo.processInfo.physicalMemory)

            return (usedMemory / totalMemory) * 100.0
        }



}
