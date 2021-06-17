//
//  MedicineBasket.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 09/04/21.
//

import Foundation
import CoreData
import UIKit

class EvaluationDataRepository {
    
    static let shared = EvaluationDataRepository()
    let entityName = "Evaluations"
    
    func insertEvaluations(completed: Bool,
                           level: Int,
                           desc: String,
                           editedImage: UIImage,
                           rawImage: UIImage, challenge: Challenges) {
        
        do {
            let context = CoreDataManager.sharedManager.persistentContainer.viewContext
            
            //Add evaluation photo
            let evaluationDetails = EvaluationDetails(context: context)
            evaluationDetails.completed = false
            evaluationDetails.desc = desc
            evaluationDetails.edited_image = editedImage.jpegData(compressionQuality: 100)
            evaluationDetails.raw_image = rawImage.jpegData(compressionQuality: 100)
            evaluationDetails.challenge = challenge

            
            //Add evaluation data
            
            if getEvaluationByLevel(level: level) == nil {
                
                print("CALLED BY WHOM??")
                
                let entity: Evaluations = .init(context: context)
                entity.level = Int32(level)
                entity.addToEvaluationDetail(evaluationDetails)
            } else {
                if let entity = getEvaluationByLevel(level: level) {
                    entity.addToEvaluationDetail(evaluationDetails)
                }
            }
            
            try context.save()
            
        } catch {
            
        }

    }
    
    func getEvaluationByLevel(level: Int) -> Evaluations? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "level == %d", level)
        
        do {
            
            let item = try context.fetch(fetchRequest) as! [Evaluations]
            
            return item.first
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    
    func getAllEvaluations() -> [Evaluations] {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            
            let item = try context.fetch(fetchRequest) as! [Evaluations]
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return []
    }

    func updateEvaluationDetail(completed:Bool, desc: String, editedImage: UIImage, data: EvaluationDetails){
        
        do {
            
            let context = CoreDataManager.sharedManager.persistentContainer.viewContext

            let entityData = data

            entityData.completed = completed
            data.desc = desc
            data.edited_image = editedImage.jpegData(compressionQuality: 100)
            
            try context.save()

        } catch {

        }
    }

    
    
    func deleteEvaluations(data: Evaluations){

        let context = CoreDataManager.sharedManager.persistentContainer.viewContext

        do {
            context.delete(data)
            try context.save()

        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

    }
    
    
    func deleteAllEvaluations(){

        let context = CoreDataManager.sharedManager.persistentContainer.viewContext

        do {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

    }

}
