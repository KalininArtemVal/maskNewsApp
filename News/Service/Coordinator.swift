//
//  Coordinator.swift
//  News
//
//  Created by Калинин Артем Валериевич on 22.04.2021.
//


import UIKit

enum Event {
    case buttonTapped
}

protocol Coordinator: class {
    var navigationController: UINavigationController? { get set }
    
    func eventOccurred(with type: Event)
    func startModule()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
