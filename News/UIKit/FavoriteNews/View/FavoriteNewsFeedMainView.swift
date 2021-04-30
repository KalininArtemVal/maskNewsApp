//
//  FavoriteNewsFeedMainView.swift
//  News
//
//  Created by Калинин Артем Валериевич on 24.04.2021.
//

import UIKit

final class FavoriteNewsFeedMainView: UIView {
    
    //MARK: - Properties
    // --- CollectionView
    public let viewForCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(FavoriteNewsFeedCell.self, forCellWithReuseIdentifier: FavoriteNewsFeedCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupConstraints() {
        addSubview(viewForCollection)
        
        NSLayoutConstraint.activate([
            viewForCollection.topAnchor.constraint(equalTo: topAnchor),
            viewForCollection.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewForCollection.trailingAnchor.constraint(equalTo: trailingAnchor),
            viewForCollection.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}
