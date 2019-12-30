//
//  FoodCell.swift
//  Nutrition
//
//  Created by Amy Alsaydi on 12/30/19.
//  Copyright © 2019 Amy Alsaydi. All rights reserved.
//

import UIKit

protocol FoodCellDelegate {
    func didAddItem(foodName: String, foodID: String)
}

class FoodCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var selectedFood: Food!
    var delegate: FoodCellDelegate?
    
    func configureCell(foodItem: Food) {
        nameLabel.text = foodItem.fields.item_name
        brandLabel.text = foodItem.fields.brand_name
    }
    
    
    @IBAction func addItemPressed(_ sender: UIButton) {
        delegate?.didAddItem(foodName: selectedFood.fields.item_name, foodID: selectedFood.fields.item_id)
        
    }
    
}
