//
//  UrbanSnapTests.swift
//  UrbanSnapTests
//
//  Created by Dhiky Aldwiansyah on 07/06/21.
//

import XCTest
import CoreData

@testable import UrbanSnap

class UrbanSnapTests: XCTestCase {

    var evaluatonRepo = EvaluationDataRepository.shared
    var challengeRepo = ChallengeDataRepository.shared

    override func tearDown() {
        super.tearDown()
        evaluatonRepo.deleteAllEvaluations()
        challengeRepo.deleteAllChallenges()
    }
    
    func test_evaluationData() {
        
        let expectation = self.expectation(description: "Should return correct data")
        expectation.expectedFulfillmentCount = 1
        
        //when
        
        let entity = NSEntityDescription.entity(forEntityName: "Challenges", in: CoreDataManager.sharedManager.persistentContainer.viewContext)
        let challenges = Challenges(entity: entity!, insertInto: CoreDataManager.sharedManager.persistentContainer.viewContext)

        evaluatonRepo.insertEvaluations(
            completed: true,
            level: 12,
            desc: "testing",
            editedImage: UIImage.init(),
            rawImage: UIImage.init(),
            challenge: challenges)

        let data = evaluatonRepo.getAllEvaluations()

        if let result = data.first, let evaluationDetail = result.evaluationDetail?.allObjects.last as? EvaluationDetails {
            XCTAssertEqual(result.level, 12)
            XCTAssertEqual(evaluationDetail.desc, "testing")
            expectation.fulfill()
        } else {
            XCTFail("Should return proper response")
        }

        //then
        wait(for: [expectation], timeout: 5)
        
    }

}
