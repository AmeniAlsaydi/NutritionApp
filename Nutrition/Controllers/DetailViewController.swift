//
//  DetailViewController.swift
//  Nutrition
//
//  Created by Amy Alsaydi on 12/27/19.
//  Copyright © 2019 Amy Alsaydi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var addedButton: UIButton!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var servingSizeLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var caloriesFromFat: UILabel!
    @IBOutlet weak var totalFat: UILabel!
    @IBOutlet weak var satFat: UILabel!
    @IBOutlet weak var transFat: UILabel!
    @IBOutlet weak var sodium: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var protein: UILabel!
    
    
    
    var selectedFood: Food?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    @IBAction func addedButtonPressed(_ sender: UIButton) {
        
    }
    
    func updateUI() {
        
        guard let selectedFood = selectedFood else {
            fatalError("issue with segue")
        }
        itemNameLabel.text = selectedFood.fields.item_name.capitalized
        brandNameLabel.text = selectedFood.fields.brand_name
        
        FoodAPIClient.getFoodInfo(itemID: selectedFood.fields.item_id) { (result) in
            switch result {
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let nutrition):
                DispatchQueue.main.async {
                    self.caloriesLabel.text = "Calories: \(nutrition.nf_calories?.description ?? "N/A")"
                    self.descriptionLabel.text = nutrition.item_description ?? ""
                    self.caloriesFromFat.text = "Calories from Fat: \(nutrition.nf_calories_from_fat?.description ?? "N/A")"
                    self.carbsLabel.text = "Carbohydrates: \(nutrition.nf_total_carbohydrate?.description ?? "N/A")"
                    self.sugarLabel.text = "Sugar: \(nutrition.nf_sugars?.description ?? "N/A")"
                    self.servingSizeLabel.text = "Serving Size: \(nutrition.nf_serving_size_qty?.description ?? "N/A") \(nutrition.nf_serving_size_unit ?? "")"
                    
                    self.protein.text = "Protein: \(nutrition.nf_protein?.description ?? "N/A")"
                    self.sodium.text = "Sodium: \(nutrition.nf_sodium?.description ?? "N/A")"
                    self.totalFat.text = "Total Fat: \(nutrition.nf_total_fat?.description ?? "N/A")"
                    self.satFat.text = "Saturated Fat: \(nutrition.nf_saturated_fat?.description ?? "N/A")"
                    self.transFat.text = "Trans Fat: \(nutrition.nf_trans_fatty_acid?.description ?? "N/A")"
                    
                }
            }
        }
    }
    


}
