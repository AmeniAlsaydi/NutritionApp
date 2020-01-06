//
//  addedFood.swift
//  Nutrition
//
//  Created by Amy Alsaydi on 12/27/19.
//  Copyright © 2019 Amy Alsaydi. All rights reserved.
//

import Foundation

struct AddedFood {
    let name: String
    let ingredients: [Food]
    let numberOfCals: Double?
    
static var createdFoods = [AddedFood]()
}
