//
//  NewsFeedCell.swift
//  News
//
//  Created by Калинин Артем Валериевич on 24.04.2021.
//

import UIKit

final class NewsFeedCell: UICollectionViewCell {
    
    static let identifier = "NewsFeedCell"
    
    //MARK: - Properties
    // --- ImageView
    private let titleImage: UIImageView = {
        $0.backgroundColor = .cyan
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let viewForTitle: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    
    // --- ImageView
    private let titleLabel: UILabel = {
        $0.text = "Title"
        $0.textAlignment = .left
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    //MARK: - Methods
    //setupProperties
    
    public func setupProperties(title: String?) {
        
        titleLabel.text = title ?? ""
        
        addSubview(titleImage)
        addSubview(viewForTitle)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleImage.topAnchor.constraint(equalTo: topAnchor),
            titleImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleImage.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            viewForTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewForTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            viewForTitle.bottomAnchor.constraint(equalTo: bottomAnchor),
            viewForTitle.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    // --- Select PhotoButton Button
    override func draw(_ rect: CGRect) {
        UIView.animate(withDuration: 2) {
            self.viewForTitle.applyGradientWithStartAndEndPoint(colors: [UIColor.clear, UIColor.black],
                                                                // --- Left color move to right
                                                                startTopPoint: CGPoint(x: 0, y: 0),
                                                                endTopPoint: CGPoint(x: 1, y: 1),
                                                                // --- Right color move to left
                                                                startBottomPoint: CGPoint(x: 0.5, y: 0.5),
                                                                endBottomPoint: CGPoint(x: 1, y: 1))
        }
    }
    
}
