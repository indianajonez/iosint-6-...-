//
//  Photos.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 03.04.2023.
//

import UIKit

struct Photo {
    
    // MARK: - Public properties
    
    let image: UIImage?
    
    // MARK: - Public methods
    
    static func makeCollectionPhotos() -> [Photo] {
        var collection: [Photo] = []
        for image in 0...19 {
            collection.append(Photo(image: UIImage(named: "\(image)")))
        }
        return collection
    }
    
    static func makeCollectioinPhotos() -> [UIImage] {
        var collection: [UIImage] = []
               for image in 0...19 {
                   collection.append( UIImage(named: "\(image)")!)
               }
               return collection
    }
}
