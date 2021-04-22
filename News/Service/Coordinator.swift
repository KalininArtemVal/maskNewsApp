//
//  Coordinator.swift
//  News
//
//  Created by Калинин Артем Валериевич on 22.04.2021.
//


import UIKit

protocol CoordinatorProtocol: class {
    var navigationController: UINavigationController { get }
    init(navigationController: UINavigationController)
    func startModule()
}

extension CoordinatorProtocol {
    func dismissController(animated: Bool) {
        navigationController.dismiss(animated: animated)
    }
    
    func popController(animated: Bool) {
        if navigationController.viewControllers.count == 2 {
            navigationController.navigationBar.isHidden = false
        }
        navigationController.popViewController(animated: animated)
    }
    
    func presentController(controller: UIViewController, animated: Bool) {
        navigationController.present(controller, animated: animated)
    }
    
    func pushController(controller: UIViewController, animated: Bool) {
        navigationController.pushViewController(controller, animated: animated)
    }
    
    func presentOnPresentedScreen(controller: UIViewController, animated: Bool) {
        navigationController.presentedViewController?.present(controller, animated: true, completion: nil)
    }
    
    func dismissPresentedControllerOnPresent(animated: Bool) {
        navigationController.presentedViewController?.dismiss(animated: animated)
    }
    
    func popToRoot(animated: Bool) {
        navigationController.navigationBar.isHidden = false
        navigationController.popToRootViewController(animated: animated)
    }
    
//    func hideTabBar() {
//        if let appTabBarController = navigationController.tabBarController as? AppTabBarController {
//            appTabBarController.mainView.alpha = 0.0
//            appTabBarController.mainView.isHidden = true
//        }
//    }
//    
//    func showTabBar() {
//        if let appTabBarController = navigationController.tabBarController as? AppTabBarController {
//            appTabBarController.mainView.alpha = 1.0
//            appTabBarController.mainView.isHidden = false
//        }
//    }
//    
//    func hideTabBarWithAnimation() {
//        if let appTabBarController = navigationController.tabBarController as? AppTabBarController  {
//            UIView.animate(withDuration: 0.3) {
//                appTabBarController.mainView.alpha = 0.0
//            } completion: { _ in
//                appTabBarController.mainView.isHidden = true
//            }
//        }
//    }
//    
//    func showTabBarWithAnimation() {
//        if let appTabBarController = navigationController.tabBarController as? AppTabBarController {
//            appTabBarController.mainView.isHidden = false
//            UIView.animate(withDuration: 0.3) {
//                appTabBarController.mainView.alpha = 1.0
//            }
//        }
//    }
    
    func disableSwipePopUp() {
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func enableSwipePopUp() {
        navigationController.interactivePopGestureRecognizer?.isEnabled = true
    }
}
