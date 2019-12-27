//
//  Food.swift
//  Nutrition
//
//  Created by Amy Alsaydi on 12/26/19.
//  Copyright © 2019 Amy Alsaydi. All rights reserved.
//

import Foundation


struct FoodSearch: Codable {
    let hits: [Food]
}

struct Food: Codable {
    let fields: Feild
}

struct Feild: Codable {
    let item_id: String
    let item_name: String
    let brand_name: String
}

