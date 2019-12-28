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
        let expectedCount = 35
        let searchQuery = "taco"
        let exp = XCTestExpectation(description: "foods found")
        
        
        //act
        FoodAPIClient.getFoodList(searchQuery: searchQuery) { (result) in
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
    
    func testgetFoodInfo() {
        // arrange
        let itemID = "5c46c3d50aa68cb64d0c91aa" // item id for Trader joes Italian Truffle Cheese
        let expectedCal = 110
        let exp = XCTestExpectation(description: "food info found")
        
        
        // act
        FoodAPIClient.getFoodInfo(itemID: itemID) { (result) in
            switch result {
            case .failure(let appError):
              XCTFail("appError: \(appError)")
            case .success(let foodInfo):
                XCTAssertEqual(foodInfo.nf_calories, expectedCal)
                exp.fulfill()
            }
        }
        wait(for:[exp], timeout: 5.0)
    }
}
