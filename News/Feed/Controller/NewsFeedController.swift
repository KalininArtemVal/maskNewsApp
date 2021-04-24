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
    private let mainView = NewsFeedMainView()
    private var model = NewsInfoData.model
    private let network = Network.shared
    
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
        network.getNews { [weak self] (result) in
            switch result {
            case.success(let article):
                self?.model = article.articles
                DispatchQueue.main.async { [weak self] in
                    self?.mainView.viewForCollection.reloadData()
                }
            case .failure( let error):
                print(error)
            }
        }
    }
    
}

extension NewsFeedController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsFeedCell.identifier, for: indexPath) as! NewsFeedCell
        let article = model[indexPath.row]
        cell.setupProperties(title: article.title)
        return cell
    }
    
}

//MARK: - CollectionView Delegate
extension NewsFeedController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let height = collectionView.frame.size.height / 4
        return CGSize(width: width, height: height)
    }
}
