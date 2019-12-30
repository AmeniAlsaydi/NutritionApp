//
//  NewItemViewController.swift
//  Nutrition
//
//  Created by Amy Alsaydi on 12/27/19.
//  Copyright © 2019 Amy Alsaydi. All rights reserved.
//

import UIKit

class NewItemViewController: UIViewController {

    @IBOutlet weak var textFeild: UITextField!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var createdFood = [addedFood]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func newMealButtonPressed(_ sender: UIButton) {
        
    }
    
}

// NOTES:
// The custom cell will have:
    // - The food name
    // - The brand
    // - A plus sign that will then add that food item to the array of food in the addedFood object along with the name that i get from the text feild
    // To add the item using the button on the cell I need to figure how to link it to the specific cells info??? *****
    // I think I could calulate the number of Calories but mapping through the [Food] -> this might not work because cal info is in the FoodInfo
    // Do I need to create another tab to show the list of the created foods the user adds? or should it be saved/posted to a seperate api?
