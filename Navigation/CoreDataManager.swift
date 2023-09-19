//
//  CoreDataManager.swift
//  StorageService
//
//  Created by Ekaterina Saveleva on 12.08.2023.
//

import UIKit
import CoreData
import StorageService


final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    var favoritesPost: [PostStorage] = []
    
    var didChangedPosts: (() -> ())?
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "PostStorage")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error, \((error as NSError).userInfo)")
            }
        })
        return container
    }()
    
    
    private func getPost(post: Post, context: NSManagedObjectContext) -> PostStorage? {
        let request = PostStorage.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", post.id)
        return (try? context.fetch(request))?.first
    }
    
    func addToFavorites(originPost: Post){
        persistentContainer.performBackgroundTask { [weak self] backgroundContext in
            guard self?.getPost(post: originPost, context: backgroundContext) == nil else { return }
            let post = PostStorage(context: backgroundContext)
            post.author = originPost.author
            post.id = originPost.id
            post.desc = originPost.description
            post.image = originPost.image
            post.likes = Int64(originPost.likes)
            post.views = Int64(originPost.views)
            try? backgroundContext.save()
            self?.fetchFavorites()
            
        }
    }
    
    func fetchFavorites() {
        let request = PostStorage.fetchRequest()
        favoritesPost = (try? persistentContainer.viewContext.fetch(request)) ?? []
        didChangedPosts?()
    }
    
    func deletePost(post: PostStorage) {
        let context = post.managedObjectContext
        context?.delete(post)
        try? context?.save()
        fetchFavorites()
    }
}

