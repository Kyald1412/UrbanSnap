//
//  MedicineBasket.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 09/04/21.
//

import Foundation
import CoreData

struct ObjectData {
    let desc: String
    let title: String
}

class ChallengeDataRepository {
    
    static let shared = ChallengeDataRepository()
    let entityName = Challenges.self.description()

    func insertChallenges(completed: Bool,
                       icon: String,
                       level: Int,
                       long_desc: String,
                       short_desc: String,
                       title: String,
                       photos: [String],
                       objects: [ObjectData]) {

        do {
            let context = CoreDataManager.sharedManager.newDerivedContext()
            let entity: Challenges = .init(context: context)
            
            //Add challenge data
            entity.completed = completed
            entity.level = Int32(level)
            entity.long_desc = long_desc
            entity.short_desc = short_desc
            entity.title = title
            
            //Add challenge photo
            var challengePhotos = [Any]()
            for photo in photos {
                let challengePhotoEntity = ChallengePhotos(context: context)
                challengePhotoEntity.image = photo
                challengePhotos.append(challengePhotoEntity)
            }
            entity.challengePhoto = NSSet.init(array: challengePhotos)
            
            //Add challenge objects
            var challengeObjects = [Any]()
            for object in objects {
                let challengePhotoEntity = ChallengeObjects(context: context)
                challengePhotoEntity.desc = object.desc
                challengePhotoEntity.title = object.title
                challengeObjects.append(challengePhotoEntity)
            }
            entity.challengeObject = NSSet.init(array: challengeObjects)
            
            try context.save()

        } catch {

        }
        
    }
    
    func getAllChallenges() -> [Challenges] {
        
        let context = CoreDataManager.sharedManager.newDerivedContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            
            let item = try context.fetch(fetchRequest) as! [Challenges]
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return []
    }

    func updateChallenges(completed: Bool, data: Challenges){
        
        do {
            let context = CoreDataManager.sharedManager.newDerivedContext()
            let entity = data
            entity.completed = completed
            
            try context.save()

        } catch {

        }
    }

    func deleteChallenges(data: Challenges){

        let context = CoreDataManager.sharedManager.persistentContainer.viewContext

        do {
            context.delete(data)
            try context.save()

        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

    }

}