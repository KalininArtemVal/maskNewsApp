//
//  AppTabBarModel.swift
//  News
//
//  Created by Калинин Артем Валериевич on 22.04.2021.
//

import UIKit

struct AppTabBarCellData {
    let unselectedIcon: UIImage?
    let selectedIcon: UIImage?
}

protocol AppTabBarModelProtocol {
    var choiceIndex: Int { get set }
    var allData: [AppTabBarCellData] { get }
}

final class AppTabBarModel: AppTabBarModelProtocol {
    
    var choiceIndex: Int = 0
    
    public var allData = [
        AppTabBarCellData(unselectedIcon: UIImage(named: "appTabBarMenuIcon") , selectedIcon: UIImage(named: "appTabBarMenuIcon") ),
        AppTabBarCellData(unselectedIcon: UIImage(named: "appTabBarFavoriteIcon") , selectedIcon: UIImage(named: "appTabBarFavoriteIcon") )
    ]
}
