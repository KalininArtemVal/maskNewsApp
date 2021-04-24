//
//  MainCoordinator.swift
//  News
//
//  Created by Калинин Артем Валериевич on 24.04.2021.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    
    func eventOccurred(with type: Event) {
        
    }
    
    func startModule() {
        var vc: UIViewController & Coordinating = NewsFeedController()
        vc.coordinator = self
        
        navigationController?.setViewControllers([vc], animated: false)
    }
}
