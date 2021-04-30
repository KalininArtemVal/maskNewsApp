//
//  NewsFeedCell.swift
//  News
//
//  Created by Калинин Артем Валериевич on 24.04.2021.
//
import UIKit

protocol NewsFeedCellProtocol: class {
    func tapToSave(cell: NewsFeedCell)
}

final class NewsFeedCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private let screenHeight = UIScreen.main.bounds.height
    private let screenWidth = UIScreen.main.bounds.width
    private var dataTask: URLSessionDataTask?
    
    static let identifier = "NewsFeedCell"
    weak var delegate: NewsFeedCellProtocol?
    
    // --- ImageView
    private let titleImage: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    lazy var viewForTitle: UIImageView = {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16 / 375 * screenWidth
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    // --- Label
    lazy var titleLabel: UILabel = {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 15 / 375 * screenWidth)
        $0.numberOfLines = 2
        $0.textAlignment = .left
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let activeIndicator: UIActivityIndicatorView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIActivityIndicatorView())
    
    // --- Button
    lazy var saveButton: UIButton = {
        let image = UIImage(named: "appTabBarFavoriteIcon")?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = UIColor.systemPink
        $0.setImage(image, for: .normal)
        $0.addTarget(self, action: #selector(tapOnFavoriteButton), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    //MARK: - Methods
    public func setupProperties(title: String?, url: URL?, session: URLSession) {
        activeIndicator.startAnimating()
        titleLabel.text = title
        if let url = url {
            let dataTask = session.dataTask(with: url) { [weak self] (data, _, _) in
                guard let data = data else {
                    return
                }
                let widthSize = Int(UIScreen.main.bounds.width)
                let heightSize = Int(UIScreen.main.bounds.height / 4)
                //Resize images
                let image = UIImage(data: data) //?.resizedImage(with: CGSize(width: widthSize, height: heightSize))
                DispatchQueue.main.async { [weak self] in
                    self?.titleImage.image = image
                    self?.titleImage.contentMode = .scaleAspectFill
                    self?.activeIndicator.stopAnimating()
                }
            }
            dataTask.resume()
            self.dataTask = dataTask
        }
        
        addSubview(titleImage)
        addSubview(viewForTitle)
        addSubview(saveButton)
        addSubview(activeIndicator)
        viewForTitle.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            activeIndicator.centerYAnchor.constraint(equalTo: titleImage.centerYAnchor),
            activeIndicator.centerXAnchor.constraint(equalTo: titleImage.centerXAnchor),
        ])
        
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
            viewForTitle.heightAnchor.constraint(equalToConstant: 100 / 812 * screenHeight)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: viewForTitle.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: viewForTitle.safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: viewForTitle.safeAreaLayoutGuide.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: viewForTitle.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dataTask?.cancel()
        dataTask = nil
        self.titleImage.image = nil
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
