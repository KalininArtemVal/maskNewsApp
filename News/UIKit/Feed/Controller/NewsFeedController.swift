//
//  NewsFeedController.swift
//  News
//
//  Created by Калинин Артем Валериевич on 24.04.2021.
//
import UIKit

final class NewsFeedController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    
    //MARK: - Properties
    public let mainView = NewsFeedMainView()
    private var model = NewsInfoData.model
    private var currentIndex = 0
    private let session = Network.shared.session
    
    //MARK: - Life cycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProperties()
        getNews()
    }
    
    //MARK: - Methods
    private func setupProperties() {
        mainView.viewForCollection.delegate = self
        mainView.viewForCollection.dataSource = self
    }
    
    private func getNews() {
        Network.shared.getNews { [weak self] news, error in
            if let error = error {
                print("error", error)
                return
            }
            self?.model = news?.articles ?? []
            DispatchQueue.main.async {
                self?.mainView.viewForCollection.reloadData()
            }
        }
    }
    
}

// MARK: - Extensions
extension NewsFeedController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsFeedCell.identifier, for: indexPath) as! NewsFeedCell
        cell.shadowDecorate()
        let article = model[indexPath.row]
        let articleImage = URL(string: article.urlToImage ?? "")
        cell.setupProperties(title: article.title, url: articleImage , session: session)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: - create normal coordinator!
        let article = model[indexPath.row]
        let vc = NewsDetailController(model: article)
        present(vc, animated: true)
    }
    
}

//MARK: - CollectionView Delegate
extension NewsFeedController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 30
        let height = collectionView.frame.size.height / 4
        return CGSize(width: width, height: height)
    }
}

extension NewsFeedController: NewsFeedCellProtocol {
    func tapToSave(cell: NewsFeedCell) {
        if let indexPath = mainView.viewForCollection.indexPath(for: cell) {
            for (index, value) in model.enumerated() {
                if index == indexPath.row {
                    NewsInfoData.favoriteNewsModel.append(value)
                    CoreDataService.shared.saveData(with: NewsInfoData.favoriteNewsModel)
                }
            }
        }
    }
    
}
