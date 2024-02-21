import Flutter
import UIKit

public class SwiftTfliteFlutterProcessingPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "tflite_flutter_processing", binaryMessenger: registrar.messenger())
    let instance = SwiftTfliteFlutterProcessingPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
