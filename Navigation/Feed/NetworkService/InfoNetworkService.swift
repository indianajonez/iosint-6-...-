//
//  InfoNetworkService.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 06.07.2023.
//

import Foundation

enum InfoNetworkServiceError: Error {
    case failParsing
    case corNetworkError(error: CoreNetworkManagerError)
    case badUrl
}

protocol InfoNetworkServiceProtocol {
    func requestTaskOne(number: Int, completion: @escaping (Result<String, InfoNetworkServiceError>) -> Void)
    func requestTaskTwo(completion: @escaping (UrlStarWars) -> Void)
}

final class InfoNetworkService {
    
    // MARK: - Constants
    enum Constants {
        static let baseUrl = "https://jsonplaceholder.typicode.com/todos/"
    }
    
    // MARK: - Private properties
    
    private let corNetworkService: CoreNetworkManagerProtocol
    
    
    // MARK: - Init
    init(corNetworkService: CoreNetworkManagerProtocol) {
        self.corNetworkService = corNetworkService
    }
    // MARK: - Private Methods
    
    private func makeUrlRequest(number: Int) -> URLRequest? {
        let urlString = Constants.baseUrl + String(number)
        guard let url = URL(string: urlString) else {
            return nil
        }
        return URLRequest(url: url)
    }
}


// MARK: - InfoNetworkServiceProtocol

extension InfoNetworkService: InfoNetworkServiceProtocol {
    func requestTaskOne(number: Int, completion: @escaping (Result<String, InfoNetworkServiceError>) -> Void) {
        guard let urlRequest = makeUrlRequest(number: number) else {
            return completion(.failure(.badUrl))
        }
        corNetworkService.request(for: urlRequest) { result in
            switch result {
            case .success(let data):
                
                do {
                    guard let arrayData = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                          let title = arrayData["title"] as? String
                    else {
                        completion(.failure(.failParsing))
                        return
                    }
                    completion(.success(title))
                } catch {
                    print(error)
                }
                
                
            case .failure(let error):
                completion(.failure(.corNetworkError(error: error)))
            }
        }
    }
    
    func requestTaskTwo(completion: @escaping (UrlStarWars) -> Void) {
        let endPoint = "https://swapi.dev/api/planets/1"
        let url = URL(string: endPoint)!
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, responce, error in
            
            let code = (responce as? HTTPURLResponse)?.statusCode
            guard code == 200 else {
                print("Code form server is \(code)")
                return
            }
            
            guard let data else {
                print("Data is nil")
                return
            }
            guard let result = try? JSONDecoder().decode(UrlStarWars.self, from: data)
            else{
                print("all bad")
                return
            }
            DispatchQueue.main.async {
                completion(result)
            }
        }
        task.resume()
    }
}


struct UrlStarWars: Codable {
    
    let name: String
    let orbital_period: String
    
}
//"https://swapi.dev/api/planets/"
