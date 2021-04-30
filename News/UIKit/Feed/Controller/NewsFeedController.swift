//
//  NewsFeedController.swift
//  News
//
//  Created by Калинин Артем Валериевич on 24.04.2021.
//
import UIKit

final class NewsFeedController: UIViewController {
    
    //MARK: - Properties
    public let mainView = NewsFeedMainView()
    private var filteredModel = [NewsInfoData.Article]()
    private var model = NewsInfoData.model
    private var currentIndex = 0
    private let session = Network.shared.session
    private let searchController = UISearchController(searchResultsController: nil)
    private let alertController = UIAlertController(title: "Новость добавленна в Избранные",
                                                   message: "Чтобы посмотреть, перейдите во вкладку Favorite",
                                                   preferredStyle: .actionSheet)
    private let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
               
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
   
    //MARK: - Life cycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProperties()
        getNews()
        setSearchController()
    }
    
    //MARK: - Methods
    private func setupProperties() {
        title = "Feed"
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
    
    private func setSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func filterContentForSearchText(_ searchText: String, category: NewsInfoData.Article? = nil) {
        filteredModel = model.filter { (article: NewsInfoData.Article) -> Bool in
            return article.title?.lowercased().contains(searchText.lowercased()) ?? false ||              article.description?.lowercased().contains(searchText.lowercased()) ?? false
        }
        mainView.viewForCollection.reloadData()
    }
    
}

// MARK: - Extensions
extension NewsFeedController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filteredModel.count
        }
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsFeedCell.identifier, for: indexPath) as! NewsFeedCell
        
        let searchingCity: NewsInfoData.Article
        if isFiltering {
            searchingCity = filteredModel[indexPath.row]
            let articleImage = URL(string: searchingCity.urlToImage ?? "")
            cell.setupProperties(title: searchingCity.title, url: articleImage , session: session)
            cell.delegate = self
        } else {
            let article = model[indexPath.row]
            let articleImage = URL(string: article.urlToImage ?? "")
            cell.setupProperties(title: article.title, url: articleImage , session: session)
            cell.delegate = self
        }
        cell.shadowDecorate()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isFiltering {
            let article = filteredModel[indexPath.row]
            let vc = NewsDetailController(model: article)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let article = model[indexPath.row]
            let vc = NewsDetailController(model: article)
            navigationController?.pushViewController(vc, animated: true)
        }
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
        print(#function)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
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

extension NewsFeedController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}
