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
    private let mainView = NewsDetailView()
    
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
        mainView.setupProperties(title: model.title ?? "", description: model.description ?? "", image: model.urlToImage ?? "")
    }
    
}