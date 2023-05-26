//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 25.05.2023.
//

import Foundation
import StorageService
import UIKit

protocol FeedViewModelProtocol {
    func getPost(title: String, image: UIImage?, text: String) -> Post2
    func checkPost(idPost: Int) -> Bool
    func delete(post: Post2) -> Bool
    
}

class FeedViewModel: FeedViewModelProtocol {
    
    private var arrayPost: [Post2] = []
    
    func checkPost(idPost: Int) -> Bool {
        if let _ = arrayPost.first(where: {$0.id == idPost}) {
            return true
        }
        return false
    }
    
    func getPost(title: String, image: UIImage?, text: String) -> StorageService.Post2 {
        let post = Post2(title: title, image: image, text: text)
        arrayPost.append(post)
        return post
    }
    
    func delete(post: Post2) -> Bool {
        if let post = arrayPost.first(where: {$0.id == post.id}) {
            self.arrayPost.remove(at: post.id)
            return true
        }
        return false
    }
    
}

//let post = Post2(
//       title: "Название поста",
//       image: UIImage(named: "A316DE42"),
//       text: "текст внутри данного поста, очень длинный и важный"
//   )
//   
//   let postTwo = Post2(
//       title: "Second Post",
//       image: UIImage(named: "A316DE42"),
//       text: "Text for second post")
