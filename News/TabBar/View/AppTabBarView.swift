//
//  AppTabBarView.swift
//  News
//
//  Created by Калинин Артем Валериевич on 22.04.2021.
//

import UIKit

final class AppTabBarView: UIView {
    
    // MARK: - Properties
    weak var dataSourceAndDelegate: (UICollectionViewDataSource & UICollectionViewDelegateFlowLayout)?
    
    // MARK: - Views
    private let customTabBarContainerView: UIView = {
        let blurEffect = UIBlurEffect(style: .prominent)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.98
        return view
    }()
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(AppTabBarCell.self, forCellWithReuseIdentifier: String(describing: AppTabBarCell.self))
        view.backgroundColor = .clear
        view.isScrollEnabled = false
        view.dataSource = dataSourceAndDelegate
        view.delegate = dataSourceAndDelegate
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Methods
    func setConstraints(tabBar: UITabBar, view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        addSubview(customTabBarContainerView)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            heightAnchor.constraint(equalToConstant: UIDevice.current.hasNotch ? 83 : 60),
            bottomAnchor.constraint(equalTo: tabBar.bottomAnchor),
        ])
        
        customTabBarContainerView.stretchFullOn(self)
        collectionView.stretchFullSafelyOn(self)
    }
    
}
