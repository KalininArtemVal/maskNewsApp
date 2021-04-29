//
//  NewsNetworkManager.swift
//  News
//
//  Created by Калинин Артем Валериевич on 24.04.2021.
//
import UIKit

enum NetworkManagerError: Error {
    case badResponse(URLResponse?)
    case badData
    case badLocalUrl
}

class Network {
    
    // MARK: - Properties
    private let key = "1b4e4c9c466e4b95a15dbf2269b71298"
//    private let path = "https://newsapi.org/v2/everything?q=tesla&from=2021-03-28&sortBy=publishedAt&apiKey="
    private var articles = NSCache<NSString, NSData>()
    
    public let session: URLSession = {
        URLCache.shared.memoryCapacity = 512 * 1024 * 1024
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: configuration)
    }()
    
    private enum httpMethod: String {
        case GET
    }
    static let shared = Network()
    
    //MARK: - Init
    private init() {}
    
    //MARK: - Methods
    private func generateRequest(method: String, body: Data?) -> URLRequest? {
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2021-03-29&sortBy=publishedAt&apiKey=\(key)") else {
            print("It will never heppend")
            return nil }
        var request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
        request.httpMethod = method
        if let body = body {
            request.httpBody = body
        }
        return request
    }
    
    func getNews(completion: @escaping (NewsInfoData.Articles?, Error?) -> (Void)) {
        guard let req = generateRequest(method: httpMethod.GET.rawValue,
                                        body: nil) else { return }
        let task = session.dataTask(with: req) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(nil, NetworkManagerError.badResponse(response))
                return
            }
            guard let data = data else {
                completion(nil, NetworkManagerError.badData)
                return
            }
            do {
                let response = try JSONDecoder().decode(NewsInfoData.Articles.self, from: data)
                completion(response, nil)
            } catch let error {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
