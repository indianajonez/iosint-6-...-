//
//  CoreNetworkManager.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 06.07.2023.
//

import Foundation

enum CoreNetworkManagerError: Error {
    case badUrl
    case notConnectInternet
    case badStatusCode(code: Int)
    case responseIsNil
    case dataIsNil
}

protocol CoreNetworkManagerProtocol {
    func request(for urlReqest: URLRequest, completion: @escaping (Result<Data, CoreNetworkManagerError>) -> Void)
    
}

final class CoreNetworkManager {
    
   
}

extension CoreNetworkManager: CoreNetworkManagerProtocol {
    
    func request(for urlReqest: URLRequest, completion: @escaping (Result<Data, CoreNetworkManagerError>) -> Void) {
        URLSession.shared.dataTask(with: urlReqest) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(.notConnectInternet))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(.responseIsNil))
                }
                return
            }
            
            guard httpResponse.statusCode < 400 else {
                DispatchQueue.main.async {
                    completion(.failure(.badStatusCode(code: httpResponse.statusCode)))
                }
                return
            }
            guard let data else {
                DispatchQueue.main.async {
                    completion(.failure(.dataIsNil))
                }
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
            
        }.resume()
    }
    
}
