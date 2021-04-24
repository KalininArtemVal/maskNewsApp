//
//  AppDelegate.swift
//  News
//
//  Created by Калинин Артем Валериевич on 22.04.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navVC = UINavigationController()
        
        let coordinator = MainCoordinator()
        coordinator.navigationController = navVC
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navVC
        window.makeKeyAndVisible()
        self.window = window
        
        coordinator.startModule()
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

//extension AppDelegate {
//    private func createFlow() {
//        let appCoordinator = AppCoordinator()
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = appCoordinator.startApplication()
//        window?.makeKeyAndVisible()
//        
//        let view = SplashScreenView()
//        view.frame = UIScreen.main.bounds
//        window?.addSubview(view)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            view.createAnimation()
//            view.endAnimation = {
//                view.removeFromSuperview()
//            }
//        }
//    }
//}
