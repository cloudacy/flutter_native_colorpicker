import Flutter
import UIKit

@available(iOS 14.0, *)
public class SwiftFlutterNativeColorpickerPlugin: NSObject, FlutterPlugin {
  
  private var colorPicker: UIColorPickerViewController
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_native_colorpicker/method", binaryMessenger: registrar.messenger())
    
    let eventChannel = FlutterEventChannel(name: "flutter_native_colorpicker/event", binaryMessenger: registrar.messenger())
    
    let picker = UIColorPickerViewController()
    picker.modalPresentationStyle = .popover
    let handler = SwiftFlutterNativeColorpickerEventHandler()
    picker.delegate = handler
    eventChannel.setStreamHandler(handler)
    
    let instance = SwiftFlutterNativeColorpickerPlugin(picker)
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
  
  @available(iOS 14.0, *)
  init(_ picker: UIColorPickerViewController) {
    self.colorPicker = picker
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let arguments = call.arguments as! Dictionary<String, Any>

    let viewController = UIApplication.shared.keyWindow?.rootViewController
    
    if let popoverController = colorPicker.popoverPresentationController {
      guard let sourceDict = arguments["origin"] as? Dictionary<String, Double> else {
        result(FlutterError(code: "BadArguments", message: "Origin must be a Map containing x, y, width, and height properties", details: nil))
        return
      }
      
      let sourceRect = CGRect(x: sourceDict["x"]!, y: sourceDict["y"]!, width: sourceDict["width"]!, height: sourceDict["height"]!)
      
      popoverController.sourceView = viewController?.view
      popoverController.sourceRect = sourceRect
    }

    viewController?.present(colorPicker, animated: true)
  }
}

@available(iOS 14.0, *)
public class SwiftFlutterNativeColorpickerEventHandler : NSObject, FlutterStreamHandler, UIColorPickerViewControllerDelegate {
  private var _eventSink: FlutterEventSink?

  public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    _eventSink = events
    return nil
  }
  
  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    _eventSink = nil
    return nil
  }
  
  public func colorPickerViewControllerDidSelectColor(_ picker: UIColorPickerViewController) {
    let c = picker.selectedColor.cgColor.components
    
    if (c == nil) {
      return
    }

    let r = Float(c![0])
    let g = Float(c![1])
    let b = Float(c![2])
    let a = Float(c![3])

    _eventSink?([lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255)])
  }
}
