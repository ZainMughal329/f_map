import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
//   [GMSServices provideAPIKey:@"AIzaSyDybIfmudV9fS8lKkTxp3t_S4z6rrBZBXg"];
  GMSServices.provideAPIKey("AIzaSyDybIfmudV9fS8lKkTxp3t_S4z6rrBZBXg")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
