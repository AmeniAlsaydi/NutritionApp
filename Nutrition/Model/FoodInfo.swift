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
    let nf_calories: Double?
    let nf_calories_from_fat: Double?
    let nf_total_fat: Double?
    let nf_saturated_fat: Double?
    let nf_trans_fatty_acid: Double?
    let nf_total_carbohydrate: Double?
    let nf_sugars: Double?
    let nf_serving_size_qty: Double?
    let nf_serving_size_unit: String?
    let nf_protein: Double?
    let nf_sodium: Double?
    let nf_cholesterol: Double?
    
}
