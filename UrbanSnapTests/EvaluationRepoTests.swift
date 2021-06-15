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
     
        let evaluations = repo.insertEvaluations(
            completed: true,
            level: 12,
            desc: "testing",
            editedImage: UIImage.init(),
            rawImage: UIImage.init())

        
        if let expectedResponseData = evaluations {
            XCTAssertEqual(expectedResponseData.level, 0)
            expectation.fulfill()
        } else {
            XCTFail("Should return proper response")
        }
        
//        let data = repo.getAllEvaluations()
//
//        if let result = data.first {
//            XCTAssertEqual(result.level, 0)
//            expectation.fulfill()
//        } else {
//            XCTFail("Should return proper response")
//        }

        //then
        wait(for: [expectation], timeout: 5)
        
    }

}
