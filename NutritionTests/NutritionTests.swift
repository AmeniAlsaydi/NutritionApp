//
//  NutritionTests.swift
//  NutritionTests
//
//  Created by Amy Alsaydi on 12/26/19.
//  Copyright © 2019 Amy Alsaydi. All rights reserved.
//


import XCTest
@testable import Nutrition
class NutritionTests: XCTestCase {

    func testgetFood() {
        // arrange
        let expectedCount = 20
        let searchQuery = "taco"
        let exp = XCTestExpectation(description: "foods found")
        
        
        //act
        FoodAPIClient.getFoods(searchQuery: searchQuery) { (result) in
            switch result {
            case .failure(let appError):
                XCTFail("appError: \(appError)")
            case .success(let foods):
                
                XCTAssertEqual(foods.count, expectedCount)
                exp.fulfill()
            }
        }
        wait(for:[exp], timeout: 5.0)
    }
}
