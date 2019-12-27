//
//  FoodAPI.swift
//  Nutrition
//
//  Created by Amy Alsaydi on 12/26/19.
//  Copyright © 2019 Amy Alsaydi. All rights reserved.
//

import Foundation

struct FoodAPIClient {
    static func getFoodList(searchQuery: String, completion: @escaping (Result<[Food], AppError>)-> ()) {
       
         let endpointURL = "https://api.nutritionix.com/v1_1/search/\(searchQuery)?results=0%3A35&cal_min=0&cal_max=50000&fields=item_name%2Cbrand_name%2Citem_id%2Cbrand_id&appId=\(SecretKey.appId)&appKey=\(SecretKey.appkey)"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL))) //  assigning the competion handler a failure
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) {(result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let results = try JSONDecoder().decode(FoodSearch.self, from: data)
                    let foods = results.hits
                    completion(.success(foods))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
                
            }


    }
}
    
    static func getFoodInfo() {
        
    }
}
