//
//  tabbarcont.swift
//  News
//
//  Created by Калинин Артем Валериевич on 29.04.2021.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    // MARK: - Properties
    private let generator = UIImpactFeedbackGenerator(style: .medium)
    private let newsFeedController = UINavigationController(rootViewController: NewsFeedController())
    private let favoriteNewsFeedController = UINavigationController(rootViewController: FavoriteNewsController())
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTapBar()
        setupPropertiesForTabBar()
    }
    
    // MARK: - Methods
    private func setupTapBar() {
        delegate = self
        viewControllers = [newsFeedController, favoriteNewsFeedController]
    }
    
    private func setupPropertiesForTabBar() {
        let newsFeedImage = UIImage(named: "appTabBarMenuIcon")?.resizedImage(with: CGSize(width: 23, height: 23))
        let favoriteNwsFeedImage = UIImage(named: "appTabBarFavoriteIcon")?.resizedImage(with: CGSize(width: 23, height: 23))
        let item1 = UITabBarItem(title: nil, image: newsFeedImage, tag: 0)
        let item2 = UITabBarItem(title: nil, image: favoriteNwsFeedImage, tag: 1)

        newsFeedController.tabBarItem = item1
        favoriteNewsFeedController.tabBarItem = item2
        self.tabBar.tintColor = .systemPink
    }

}

extension CustomTabBarController: UITabBarControllerDelegate  {
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.generator.impactOccurred(intensity: 0.4)
        return TabBarAnimatedTransitioning()
    }
}

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
