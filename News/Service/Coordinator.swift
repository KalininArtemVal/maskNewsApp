//
//  Coordinator.swift
//  News
//
//  Created by Калинин Артем Валериевич on 22.04.2021.
//


import UIKit

protocol Coordinator: class {
    
    var navigationController: UINavigationController? { get set }
    
    func startModule()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
