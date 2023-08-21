//
//  Post.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 21.03.2023.
//

import UIKit
import CoreData

public struct Post {
    public var id = UUID().uuidString
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
        return [
            Post(author: "Лохматый", description: "Сегодня еще ничего не елдлапрои мывлмтывжл рмфжвмо фжщимофж шмрофущш комфщшумрфшзгкеи рфшкгеримфшыкгеирыал опирш жагиргшыкер", image: "Лохматый", likes: 10, views: 320),
            Post(author: "CalmCat", description: "Молчу весь день. Тяжело.", image: "CalmCat", likes: 10, views: 320),
            Post(author: "MaybeImNotCat", description: "Блохи и клещи худщие враги", image: "MaybeImNotCat", likes: 10, views: 320),
            Post(author: "ImOkay", description: "Бегаю за хвостом. Пока не поймал.", image: "ImOkay", likes: 10, views: 320)
        ]

    }
}

