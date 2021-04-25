//
//  NewsDetailView.swift
//  News
//
//  Created by Калинин Артем Валериевич on 24.04.2021.
//
import Kingfisher
import UIKit

protocol NewsDetailViewProtocol: class {
    func tapOnFavorite()
}

final class NewsDetailView: UIView {
    
    //MARK: - Properties
    
    private let screenHeight = UIScreen.main.bounds.height
    private let screenWidth = UIScreen.main.bounds.width
    weak var delegate: NewsDetailViewProtocol?
    // --- Labels
    private let titleLabel: UILabel = {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 30)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    let descriptionLabel: UITextView = {
        $0.layer.masksToBounds = true
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.autoresizingMask = .flexibleWidth
        $0.autoresizingMask = .flexibleHeight
        $0.textContainer.widthTracksTextView = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextView())
    
    // --- ImageView
    private let titleImage: UIImageView = {
        $0.backgroundColor = .red
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    // --- Button
    lazy var favoriteButton: UIButton = {
        let image = UIImage(named: "appTabBarFavoriteIcon")?.withRenderingMode(.alwaysOriginal)
        $0.setImage(image, for: .normal)
        $0.addTarget(self, action: #selector(tapOnFavoriteButton), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    // --- ScrollView
    private let scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        return $0
    }(UIScrollView())
    
    // MARK: - Init
    //MARK: - Init
    init(subscriber: NewsDetailViewProtocol) {
        super.init(frame: UIScreen.main.bounds)
        self.delegate = subscriber
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    public func setupProperties(title: String?, description: String?, image: String?) {
        titleLabel.text = title
        descriptionLabel.text = description
        guard let image = image else { return titleImage.backgroundColor = .cyan }
        let url = URL(string: image)
        titleImage.kf.setImage(with: url)
    }
    
    private func setupConstraints() {
        addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(titleImage)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30 / 812 * screenHeight),
            favoriteButton.widthAnchor.constraint(equalToConstant: 30 / 375 * screenWidth),
        ])
        
        NSLayoutConstraint.activate([
            titleImage.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor),
            titleImage.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor),
            titleImage.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor),
            titleImage.heightAnchor.constraint(equalToConstant: 200 / 812 * screenHeight),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleImage.bottomAnchor, constant: 20 / 812 * screenHeight),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20 / 812 * screenHeight),
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 200 / 812 * screenHeight),
        ])
    }
    
    @objc func tapOnFavoriteButton() {
        delegate?.tapOnFavorite()
    }
    
}
