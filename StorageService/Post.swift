//
//  Post.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 21.03.2023.
//

import UIKit
import CoreData

public struct Post {
    public var id: String
    public let author: String
    public let description: String
    public let image: String
    public var likes: Int
    public var views: Int
}

extension Post {
//    public init(author: String, description: String, image: String, likes: Int, views: Int) {
//        self.author = author
//        self.description = description
//        self.image = image
//        self.likes = likes
//        self.views = views
//    }
    
    public init(data: NSManagedObject) {
        self.id = (data.value(forKey: "id") as? String)!
        self.author = (data.value(forKey: "author") as? String)!
        self.description = (data.value(forKey: "desc") as? String)!
        self.image = (data.value(forKey: "image") as? String)!
        self.likes = (data.value(forKey: "likes") as? Int)!
        self.views = (data.value(forKey: "views") as? Int)!

    }
}

public struct Post2 {
    static var id = 0
    public let id: Int
    public let title: String?
    public let image: UIImage?
    public let text: String?
    
    public init(title: String?, image: UIImage?, text: String?) {
        self.title = title
        self.image = image
        self.text = text
        self.id = Post2.id
        Post2.id += 1
    }
}

extension Post2 {
    public static func make() -> [Post] {
        let localizedPostsInformationAuthor1 = NSLocalizedString("PostsInformationAuthor1", comment: "testing")
        let localizedPostsInformationAuthor2 = NSLocalizedString("PostsInformationAuthor2", comment: "testing")
        let localizedPostsInformationAuthor3 = NSLocalizedString("PostsInformationAuthor3", comment: "testing")
        let localizedPostsInformationAuthor4 = NSLocalizedString("PostsInformationAuthor4", comment: "testing")
        
        let localizedPostsInformationDescription4 = NSLocalizedString("PostsInformationDescription1", comment: "testing")
        let localizedPostsInformationDescription3 = NSLocalizedString("PostsInformationDescription2", comment: "testing")
        let localizedPostsInformationDescription2 = NSLocalizedString("PostsInformationDescription3", comment: "testing")
        let localizedPostsInformationDescription1 = NSLocalizedString("PostsInformationDescription4", comment: "testing")
        
        
        return [
            Post(id: "12", author: localizedPostsInformationAuthor1, description: localizedPostsInformationDescription4, image: "Лохматый", likes: 10, views: 320),
            Post(id: "23",author: localizedPostsInformationAuthor2, description: localizedPostsInformationDescription3, image: "CalmCat", likes: 10, views: 320),
            Post(id: "45",author: localizedPostsInformationAuthor3, description: localizedPostsInformationDescription2, image: "MaybeImNotCat", likes: 10, views: 320),
            Post(id: "56",author: localizedPostsInformationAuthor4, description: localizedPostsInformationDescription1, image: "ImOkay", likes: 10, views: 320)
        ]

    }
}

