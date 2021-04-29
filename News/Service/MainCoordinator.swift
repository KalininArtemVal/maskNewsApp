//
//  MainCoordinator.swift
//  News
//
//  Created by Калинин Артем Валериевич on 24.04.2021.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    
    func startModule() {
        var vc: UIViewController & Coordinating = AppTabBarController()
        vc.coordinator = self
        
        navigationController?.setViewControllers([vc], animated: false)
    }
}

