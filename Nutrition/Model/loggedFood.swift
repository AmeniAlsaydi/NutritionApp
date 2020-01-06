//
//  loggedFood.swift
//  Nutrition
//
//  Created by Amy Alsaydi on 1/3/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation
enum Meal: String, CaseIterable {
    case breakfast
    case lunch
    case dinner
}

struct LoggedFood {
    let name: String
    let meal: Meal
    //let numOfCal: Double
    
    static var loggedFoods = [LoggedFood]()
    
    static func sectionMeal() -> [[LoggedFood]] {
        
        let sortedMeals = loggedFoods.sorted { $0.meal.rawValue < $1.meal.rawValue }
        
        let mealTypes: Set<String> = Set(loggedFoods.map { $0.meal.rawValue })
        
        var mealsArr = Array(repeating: [LoggedFood](), count: mealTypes.count)
        
        var currentIndex = 0
        var currentMeal = sortedMeals.first?.meal.rawValue

        for food in sortedMeals {
            if food.meal.rawValue == currentMeal {
                mealsArr[currentIndex].append(food)
            } else {
                currentIndex += 1
                currentMeal = food.meal.rawValue
                mealsArr[currentIndex].append(food)
            }
        }
        
        return mealsArr
    }
}
