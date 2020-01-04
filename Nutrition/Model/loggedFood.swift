//
//  loggedFood.swift
//  Nutrition
//
//  Created by Amy Alsaydi on 1/3/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation
enum Meal {
    case breakfast
    case lunch
    case dinner
}

struct LoggedFood {
    let name: String
    let meal: Meal
    //let numOfCal: Double
    
    static var loggedFoods = [LoggedFood]()
}
