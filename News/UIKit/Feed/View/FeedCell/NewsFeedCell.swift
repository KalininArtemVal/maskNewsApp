//
//  NewsFeedCell.swift
//  News
//
//  Created by Калинин Артем Валериевич on 24.04.2021.
//
import Kingfisher
import UIKit

protocol NewsFeedCellProtocol: class {
    func tapToSave(cell: NewsFeedCell)
}

final class NewsFeedCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let identifier = "NewsFeedCell"
    weak var delegate: NewsFeedCellProtocol?
    
    private let screenHeight = UIScreen.main.bounds.height
    private let screenWidth = UIScreen.main.bounds.width
    
    // --- ImageView
    private let titleImage: UIImageView = {
        $0.contentMode = .scaleAspectFill //
        $0.backgroundColor = .cyan
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let viewForTitle: UIImageView = {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    // --- ImageView
    private let titleLabel: UILabel = {
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    // --- Button
    lazy var saveButton: UIButton = {
        let image = UIImage(named: "appTabBarFavoriteIcon")?.withRenderingMode(.alwaysOriginal)
        $0.setImage(image, for: .normal)
        $0.addTarget(self, action: #selector(tapOnFavoriteButton), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    //MARK: - Methods
    public func setupProperties(title: String?, image: String?) {
        
        titleLabel.text = title ?? ""
        
        guard let image = image else { return titleImage.backgroundColor = .cyan }
        let url = URL(string: image)
        titleImage.kf.setImage(with: url)
        
        addSubview(titleImage)
        addSubview(viewForTitle)
        addSubview(saveButton)
        viewForTitle.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10 / 812 * screenHeight),
            saveButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10 / 375 * screenWidth),
            saveButton.heightAnchor.constraint(equalToConstant: 40 / 812 * screenHeight),
            saveButton.widthAnchor.constraint(equalToConstant: 40 / 375 * screenWidth),
        ])
        
        NSLayoutConstraint.activate([
            titleImage.topAnchor.constraint(equalTo: topAnchor),
            titleImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleImage.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            viewForTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            viewForTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            viewForTitle.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            viewForTitle.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: viewForTitle.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: viewForTitle.safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: viewForTitle.safeAreaLayoutGuide.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: viewForTitle.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // --- Select PhotoButton Button
    override func draw(_ rect: CGRect) {
        UIView.animate(withDuration: 2) {
            self.viewForTitle.applyGradientWithStartAndEndPoint(
                colors: [UIColor.clear, UIColor.black],
                // --- Left color move to right
                startTopPoint: CGPoint(x: 0, y: 1),
                endTopPoint: CGPoint(x: 0, y: 1),
                // --- Right color move to left
                startBottomPoint: CGPoint(x: 1, y: 0),
                endBottomPoint: CGPoint(x: 1, y: 1))
        }
    }
    
    @objc func tapOnFavoriteButton() {
        delegate?.tapToSave(cell: self)
    }
    
}
