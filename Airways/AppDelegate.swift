import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let configurator = AWAirportsConfiguratorImplementation()
        let controller = AWAirportsViewImplementation(configurator: configurator)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = AWNavigationController(rootViewController: controller)
        self.window?.makeKeyAndVisible()
        
        
        return true
    }

}

