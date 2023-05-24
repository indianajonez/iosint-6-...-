//
//  FeedModel.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 23.05.2023.
//

import Foundation

class FeedModel {
    
    private var secretWord: String = "12345"
    
    func check(word: String) -> Bool {
        self.secretWord == word
    }
}
