//
//  CoreDataManager.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 08/04/21.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let sharedManager = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: Constants.dataModel)
        
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.undoManager = nil
        container.viewContext.shouldDeleteInaccessibleFaults = true
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }()
    
    func saveContext () {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func preloadData(){
        if !UserDefaultManager.shared.isOnboardingCompleted() {
            preloadDataChallenge()
        }
    }
    
    func newDerivedContext() -> NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        return context
    }
    
    func deleteAllData(){
        
        let storeCoordinator = persistentContainer.persistentStoreCoordinator
        let storeDescription = persistentContainer.persistentStoreDescriptions[0]
        guard let storeURL = storeDescription.url else {
            return
        }
        
        do {
            try storeCoordinator.destroyPersistentStore(at: storeURL, ofType: NSSQLiteStoreType, options: nil)
        }
        catch {
            return
        }
        
        storeCoordinator.addPersistentStore(with: storeDescription) {
            (persistentStoreCoordinator, error) in
            
            if let error = error {
                print("\(error)")
            }
        }
        
        //Reload the data again
        preloadData()
    }
    
}


extension CoreDataManager {
    
    func preloadDataEvaluation(){
        EvaluationDataRepository.shared.insertEvaluations(
            completed: true,
            level: 10,
            desc: "",
            editedImage: UIImage.init(),
            rawImage: UIImage.init())
    }
    
    func preloadDataChallenge(){
        
        // Level 1
        ChallengeDataRepository.shared.insertChallenges(
            completed: false,
            icon: "ilustrasi level 1",
            level: 1,
            long_desc: "Take a picture of a building(s) and the sky. Make sure to separate your objects into 2 layers: foreground and background. In this picture:",
            short_desc: "Learn to shoot still urban objects with two layers",
            title: "Building and The Sky",
            photos: ["Onboarding-Learn","Onboarding-Practice"],
            objects: [ObjectData(desc: "Sky is the background", title: "Banana"),
                      ObjectData(desc: "Buildings are the foreground and the focus object", title: "Egg")])
        
        ChallengeDataRepository.shared.insertChallenges(
            completed: false,
            icon: "ilustrasi level 2",
            level: 2,
            long_desc: "Take a picture of a person, building and the sky. Make sure to separate your objects into 3 layers: foreground, middle ground, and background. In this picture:",
            short_desc: "Learn to shoot still urban objects with three layers",
            title: "A Person, Building, and The Sky",
            photos: ["Onboarding-Learn","Onboarding-Practice"],
            objects: [ObjectData(desc: "A person is the foreground and the focus object", title: "Person"),
                      ObjectData(desc: "Building is the middle ground", title: "Building"),
                      ObjectData(desc: "Sky is the background", title: "Sky")])
        
        ChallengeDataRepository.shared.insertChallenges(
            completed: false,
            icon: "ilustrasi level 3",
            level: 3,
            long_desc: "Take a picture of a car, building and the sky. Make sure to separate your objects into 3 layers: foreground, middle ground, and background. In this picture:",
            short_desc: "Learn to shoot moving urban objects with three layers",
            title: "A Car, Building, and The Sky",
            photos: ["Onboarding-Learn","Onboarding-Practice"],
            objects: [ObjectData(desc: "A car is the foreground and the focus object", title: "Car"),
                      ObjectData(desc: "Building is the middle ground", title: "Building"),
                      ObjectData(desc: "Sky is the background", title: "Sky")])
        
    }
    
}
