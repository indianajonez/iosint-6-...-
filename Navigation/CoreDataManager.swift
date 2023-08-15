//
//  CoreDataManager.swift
//  StorageService
//
//  Created by Ekaterina Saveleva on 12.08.2023.
//

import UIKit
import CoreData
import StorageService

protocol CoreDataManagerProtocol {
    func save()
    func delete(_ object: NSManagedObject)
    func fetchAllData(_ request: NSFetchRequest<NSManagedObject>) -> [NSManagedObject]
    func createNewPost(_ data: Post) -> NSManagedObject
}

final class CoreDataManager: CoreDataManagerProtocol {
    
    static let shared = CoreDataManager()
    
    private let appDelegate: AppDelegate
    private let managetContext: NSManagedObjectContext
    
    private init() {
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managetContext = appDelegate.persistentContainer.viewContext
    }
    
    func save() {
        do {
            try managetContext.save()
        } catch let error as NSError {
            print("\(error). Info: \(error.userInfo)")
        }
    }
    
    func delete(_ object: NSManagedObject) {
        managetContext.delete(object)
    }
    
    func fetchAllData(_ request: NSFetchRequest<NSManagedObject>) -> [NSManagedObject] {
        do {
            let result = try managetContext.fetch(request)
            return result
        } catch let error as NSError {
            print("\(error). Info: \(error.userInfo)")
            return []
        }
    }
    
    func createNewPost(_ data: Post) -> NSManagedObject {
        let entity = NSEntityDescription.entity(forEntityName: "PostStorage", in: managetContext)!
        let newPost = NSManagedObject(entity: entity, insertInto: managetContext)
        newPost.setValue(data.id, forKey: "id")
        newPost.setValue(data.author, forKey: "author")
        newPost.setValue(data.description, forKey: "desc")
        newPost.setValue(data.image, forKey: "image")
        newPost.setValue(data.views, forKey: "views")
        newPost.setValue(data.likes, forKey: "likes")
        return newPost
    }
}
