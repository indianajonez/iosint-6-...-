//
//  Post.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 21.03.2023.
//

import UIKit

public struct Post {
    public let id = UUID()
    public let author: String
    public let description: String
    public let image: String
    public var likes: Int
    public var views: Int
    
    public init(author: String, description: String, image: String, likes: Int, views: Int) {
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views
    }
}

public struct Post2 {
    public let title: String?
    public let image: UIImage?
    public let text: String?
    
    public init(title: String?, image: UIImage?, text: String?) {
        self.title = title
        self.image = image
        self.text = text
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

