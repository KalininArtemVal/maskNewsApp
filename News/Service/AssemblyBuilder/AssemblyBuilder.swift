//
//  AssemblyBuilder.swift
//  News
//
//  Created by Калинин Артем Валериевич on 23.04.2021.
//

import UIKit

protocol AllTemplatesAssemblyBuilderProtocol {
    func createAllTemplatesController(coordinator: AllTemplatesCoordinatorProtocol, model: AllNewsScreenModelProtocol) -> UIViewController
    func createMainCardController(coordinator: AllTemplatesCoordinatorProtocol, model: NewsInfoData) -> UIViewController
    func createFullScreenCardController(coordinator: AllTemplatesCoordinatorProtocol, model: NewsInfoData, item: Int) -> UIViewController
    func createEditScreenViewController(coordinator: AllTemplatesCoordinatorProtocol, model: NewsInfoData, item: Int) -> UIViewController
    func createSettingsScreen(coordinator: AllTemplatesCoordinatorProtocol) -> UIViewController
}

final class AllTemplatesAssemblyBuilder: AllTemplatesAssemblyBuilderProtocol {
    
    func createAllTemplatesController(coordinator: AllTemplatesCoordinatorProtocol, model: AllNewsScreenModelProtocol) -> UIViewController {
        let controller = AllTemplatesScreenVC(coordinator: coordinator, model: model)
        return controller
    }
    
    func createMainCardController(coordinator: AllTemplatesCoordinatorProtocol, model: TemplateInfoData) -> UIViewController {
        let controller = MainCardVC(coordinator: coordinator, model: model)
        return controller
    }
    
    func createFullScreenCardController(coordinator: AllTemplatesCoordinatorProtocol, model: TemplateInfoData, item: Int) -> UIViewController {
        let controller = FullScreenCardVC(coordinator: coordinator, model: model, item: item)
        return controller
    }
    
    func createEditScreenViewController(coordinator: AllTemplatesCoordinatorProtocol, model: TemplateInfoData, item: Int) -> UIViewController {
        let controller = EditScreenViewController(coordinator: coordinator, model: model, item: item)
        return controller
    }
    
    func createSettingsScreen(coordinator: AllTemplatesCoordinatorProtocol) -> UIViewController {
        let controller = SettingsVC(coordinator: coordinator, model: SettingsModel())
        return controller
    }
}
