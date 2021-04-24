//
//  NewsDetailView.swift
//  News
//
//  Created by Калинин Артем Валериевич on 24.04.2021.
//
import Kingfisher
import UIKit

final class NewsDetailView: UIView {
    
    //MARK: - Properties
    
    private let screenHeight = UIScreen.main.bounds.height
    private let screenWidth = UIScreen.main.bounds.width
    
    // --- Labels
    private let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
//    private let descriptionLabel: UILabel = {
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        return $0
//    }(UILabel())
    
    let descriptionLabel: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.font = UIFont.systemFont(ofSize: 15)
        view.backgroundColor = .white
        return view
    }()
    
    // --- ImageView
    private let titleImage: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    // --- ScrollView
    private let scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .cyan
        return $0
        }(UIScrollView())
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleImage.bottomAnchor, constant: 20 / 812 * screenHeight)
        ])
        
        NSLayoutConstraint.activate([
            titleImage.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor),
            titleImage.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor),
            titleImage.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor),
            titleImage.heightAnchor.constraint(equalToConstant: 200 / 812 * screenHeight),
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 200 / 812 * screenHeight),
        ])
        
        
    }
    
}
