//
//  TypeError.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 12.06.2023.
//

import Foundation

enum TypeError: Error {
    
    enum Network: Error {
        case badRequest
    }
    
    enum Auth: Error {
        case notFound
        case emptyTextField
    }
}

let error = TypeError.Network.badRequest


