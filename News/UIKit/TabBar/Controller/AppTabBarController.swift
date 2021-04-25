//
//  AppTabBarController.swift
//  News
//
//  Created by Калинин Артем Валериевич on 22.04.2021.
//

import UIKit

final class AppTabBarController: UITabBarController, Coordinating {
    
    var coordinator: Coordinator?
    
    // MARK: - Properties
    private let allNews = NewsFeedController()
    
    private let favoriteNews = FavoriteNewsController()
    
    private let model = AppTabBarModel()
    private let generator = UIImpactFeedbackGenerator(style: .medium)
    
    private(set) lazy var mainView: AppTabBarView = {
        let view = AppTabBarView()
        view.dataSourceAndDelegate = self
        return view
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        collectionViewSelectItem()
    }
    
    private func setupTabBar() {
        delegate = self
        tabBar.isHidden = true
        mainView.setConstraints(tabBar: tabBar, view: view)
        
        
        
        viewControllers = [allNews,
                           favoriteNews]
    }

    private func collectionViewSelectItem() {
        DispatchQueue.main.async {
            self.mainView.collectionView.selectItem(
                at: IndexPath(item: self.model.choiceIndex, section: 0),
                animated: false,
                scrollPosition: .centeredVertically
            )
        }
    }
}

// MARK: - CollectionView DataSource
extension AppTabBarController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AppTabBarCell.self), for: indexPath) as? AppTabBarCell else { return UICollectionViewCell() }
        if indexPath.item == 0 {
            cell.isLeft = true
        }
        cell.iconImage = model.allData[indexPath.item]
        
        return cell
    }
}

// MARK: - CollectionView Delegate
extension AppTabBarController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ceil(collectionView.frame.width / 2), height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == model.choiceIndex {
            return
        }
        selectedIndex = indexPath.row
        collectionView.deselectItem(at: IndexPath(item: model.choiceIndex, section: 0), animated: true)
        model.choiceIndex = indexPath.row
    }
}


extension AppTabBarController: UITabBarControllerDelegate  {
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.generator.impactOccurred(intensity: 0.4)
        return TabBarAnimatedTransitioning()
    }
}

// MARK: - UIViewControllerAnimatedTransitioning
final class TabBarAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let destination = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        
        destination.alpha = 0.0
        destination.transform = .init(scaleX: 1.5, y: 1.5)
        transitionContext.containerView.addSubview(destination)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            destination.transform = .identity
            destination.alpha = 1
        }, completion: { transitionContext.completeTransition($0) })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.30
    }
    
}
