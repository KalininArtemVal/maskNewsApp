//
//  NewsDetailController.swift
//  News
//
//  Created by Калинин Артем Валериевич on 24.04.2021.
//

import UIKit

final class NewsDetailController: UIViewController {
    
    //MARK: - Properties
    private let model: NewsInfoData.Article
    private let session = Network.shared.session
    lazy private var mainView = NewsDetailView(subscriber: self)
    
    //MARK: - Init
    init(model: NewsInfoData.Article) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProperties()
    }
    
    //MARK: - Methods
    private func setupProperties() {
        let urlImage = URL(string: model.urlToImage ?? "")
        mainView.setupProperties(title: model.title, description: model.description, url: urlImage, session: session)
    }
    
}

extension NewsDetailController: NewsDetailViewProtocol {
    func tapOnFavorite() {
        print(#function)
        NewsInfoData.favoriteNewsModel.append(model)
        CoreDataService.shared.saveData(with: NewsInfoData.favoriteNewsModel)
    }
}
