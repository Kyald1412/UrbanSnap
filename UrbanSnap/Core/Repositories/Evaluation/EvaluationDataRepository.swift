//
//  MedicineBasket.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 09/04/21.
//

import Foundation
import CoreData

class EvaluationDataRepository {
    
    static let shared = EvaluationDataRepository()
//    let entityName = Evaluations.self.description()

    func addEvaluations(data: Evaluations) {

        do {
            let context = CoreDataManager.sharedManager.newDerivedContext()
            let entity: Evaluations = .init(context: context)
            
            try context.save()

        } catch {

        }
        
    }

    func updateEvaluations(data: Evaluations){
        
        do {
            let context = CoreDataManager.sharedManager.newDerivedContext()
            let entity = data
            
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

}
