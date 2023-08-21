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
    
    
    // настроить чтобы при сохранении пост не повторялся и была возможность его удалить из избранного. для этого нужно каждому посту присвоить не изменяющийся айдишник и прописать метод где при переборе айдишников повторяющиеся не сохранялись в кор дату.8
    func isExist(post: NSManagedObject) -> Bool {
//        let coreDataModel = NSManagedObject.fetchRequest()
//        coreDataModel.predicate = NSPredicate(format: "id == %@", post.id)
        let existPost = NSEntityDescription.entity(forEntityName: "PostStorage", in: managetContext)!
        
        do{
            let object = try managetContext.existingObject(with: post.objectID)
            
            return true
        } catch {
            return false
        }
        
    }
}

//func update(habit: Habit) -> Bool {
//    let fetchRequest = HabitCoreDataModel.fetchRequest()
//    fetchRequest.predicate =NSPredicate(format: "id == %@", habit.id)
//    do {
//        let habitCoreDataModels = try context.fetch(fetchRequest)
//        habitCoreDataModels.forEach {
//            $0.id = habit.id
//            $0.title = habit.title
//            $0.createAt = habit.createdAtString
//        }
//        guard context.hasChanges else { return false }
//        try context.save()
//        return true
//    } catch {
//        return false
//
//}
