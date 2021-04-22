//
//  AppCoordinator.swift
//  News
//
//  Created by Калинин Артем Валериевич on 22.04.2021.
//

import UIKit

protocol AppCoordinatorProtocol: class {
    func startApplication() -> UIViewController
}

final class AppCoordinator: AppCoordinatorProtocol {
    
    func startApplication() -> UIViewController {
        return AppTabBarController()
    }
}
