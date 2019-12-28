//
//  FoodInfo.swift
//  Nutrition
//
//  Created by Amy Alsaydi on 12/27/19.
//  Copyright © 2019 Amy Alsaydi. All rights reserved.
//

import Foundation

struct FoodInfo: Codable {
    let item_description: String?
    let nf_calories: Int
    let nf_calories_from_fat: Int
    let nf_total_fat: Int
    let nf_saturated_fat: Int
    let nf_trans_fatty_acid: Int
    let nf_total_carbohydrate: Int
    let nf_sugars: Int
    
}
