import UIKit
import NaverThirdPartyLogin
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        
        let controller = window.rootViewController as! FlutterViewController
        
        let flavorChannel = FlutterMethodChannel(
            name: "flavor",
            binaryMessenger: controller.binaryMessenger)
        
        flavorChannel.setMethodCallHandler({(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            let flavor = Bundle.main.infoDictionary?["App Flavor"]
            result(flavor)
        })
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    

    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        var applicationResult = false
        if (!applicationResult) {
           applicationResult = NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options)
        }
        // if you use other application url process, please add code here.
        
        if (!applicationResult) {
           applicationResult = super.application(app, open: url, options: options)
        }
        return applicationResult
    }
}
