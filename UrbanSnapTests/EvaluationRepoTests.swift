//
//  UrbanSnapTests.swift
//  UrbanSnapTests
//
//  Created by Dhiky Aldwiansyah on 07/06/21.
//

import XCTest

@testable import UrbanSnap

class UrbanSnapTests: XCTestCase {

    var repo = EvaluationDataRepository.shared
    
    override func tearDown() {
        super.tearDown()
        repo.deleteAllEvaluations()
    }
    
    func test_evaluationData() {
        
        let expectation = self.expectation(description: "Should return correct data")
        expectation.expectedFulfillmentCount = 1
        
        //when
     
        repo.insertEvaluations(
            completed: true,
            level: 12,
            desc: "testing",
            editedImage: UIImage.init(),
            rawImage: UIImage.init())

        let data = repo.getAllEvaluations()

        if let result = data.first, let evaluationDetail = result.evaluationDetail?.allObjects.first as? EvaluationDetails {
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
