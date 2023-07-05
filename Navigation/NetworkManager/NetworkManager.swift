//
//  NetworkManager.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 29.06.2023.
//

import Foundation

struct StarShip: Codable {
    let name: String
}

struct People: Codable {
    let name: String
}

struct UrlData: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

struct UrlStarWars: Codable {
    
    let nameOfThePlanet: String
    let orbitalPeriod: Int
    
}


struct NetworkManager {

    static func requestTaskOne(complition: @escaping ([UrlData]?)-> Void) {
        let session = URLSession.shared
        let endPoint = "https://jsonplaceholder.typicode.com/todos/"
        let url = URL(string: endPoint)!
        
        let task = session.dataTask(with: url) { data, responce, error in
            do {
                let arrayData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions() )
                DispatchQueue.main.async {
                    complition(arrayData as? [UrlData])
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    static func requestTaskTwo(complition: @escaping ([UrlStarWars])-> Void) {
        let session = URLSession.shared
        let endPoint = "https://swapi.dev/api/planets/"
        let url = URL(string: endPoint)!
        
        let task = session.dataTask(with: url) { data, responce, error in
            do {
                let arrayData = try JSONDecoder().decode([UrlStarWars].self, from: data!)
                DispatchQueue.main.async {
                    complition((arrayData as? [UrlStarWars])!)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    static func request(for configuration: AppConfiguration) {
        let session = URLSession.shared
        let endPoint = "https://swapi.dev/api/"
        var fullPath: String!
        
        switch configuration {
    
        case .people(url: let url):
            fullPath = endPoint + "people/" + url
        case .starships(url: let url):
            fullPath = endPoint + "starships/" + url
        case .planets(url: let url):
            fullPath = endPoint + "planets/" + url
        }
        
        print(fullPath)
        
        let url = URL(string: fullPath)!
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
            
            do {
                
                switch configuration {
                    
                case .people(url: let url):
                    let people = try JSONDecoder().decode(People.self, from: data)
                    print("name people with number \(url) = \(people.name)")
                case .starships(url: _):
                    let stapships = try JSONDecoder().decode(StarShip.self, from: data)
                    print("name of ship = \(stapships.name)")
                case .planets(url: _):
                    ()
                }
            
            }
            catch {
                print(error.localizedDescription)
                print("JSON fail")
            }
            
        }
        task.resume()
    }
}

enum AppConfiguration {
    
/*
«https://swapi.dev/api/people/8»;
«https://swapi.dev/api/starships/3»;
«https://swapi.dev/api/planets/5».
    */

    case people(url: String)
    case starships(url: String)
    case planets(url: String)
    
}

enum CodingKeys {
    case orbitalPeriod(url: String)
    case nameOfThePlanet(url: String)
}
