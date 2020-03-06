import UIKit
import Firebase
import Flutter
import GoogleMaps
import FacebookLogin




@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
 override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?
  ) -> Bool {
    ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    GMSServices.provideAPIKey("AIzaSyCi5DH7D5JcuDi5eZTny17tOfKeuYJTEzY")
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

      @available(iOS 9.0, *)
   override func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any])
          -> Bool {
            return ApplicationDelegate.shared.application(application,  open: url, sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?,annotation: options[UIApplication.OpenURLOptionsKey.annotation])
      }

      // para iOS menor a 9.0
    override func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
          return ApplicationDelegate.shared.application(application,open: url ,sourceApplication: sourceApplication,annotation: annotation)
      }
}
