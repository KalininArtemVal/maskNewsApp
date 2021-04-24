//
//  NewsNetworkManager.swift
//  News
//
//  Created by Калинин Артем Валериевич on 24.04.2021.
//
import UIKit

class Network {
    
    // MARK: - Properties
    private let session = URLSession.shared
    private let key = "1b4e4c9c466e4b95a15dbf2269b71298"
    
    private enum httpMethod: String {
        case GET
    }
    
    static let shared = Network()
    private init() {}
    
    //MARK: - Methods
    public func getNews(competiton: @escaping (Result<NewsInfoData.Articles, Error>) -> Void) {
        guard let request = generateRequest(method: httpMethod.GET.rawValue,
                                            body: nil) else { return }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                competiton(.failure(error))
            }
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            if let data = data {
                do {
                    let article = try JSONDecoder().decode(NewsInfoData.Articles.self, from: data)
                    competiton( .success(article))
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    private func generateRequest(method: String, body: Data?) -> URLRequest? {
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2021-03-24&sortBy=publishedAt&apiKey=\(key)") else {
            print("It will never heppend")
            return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        if let body = body {
            request.httpBody = body
        }
        print(request)
        return request
    }
    
}
