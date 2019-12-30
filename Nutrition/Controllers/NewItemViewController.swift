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
    
    var foods = [Food]() {
           didSet {
               DispatchQueue.main.async {
                   self.tableView.reloadData() // updating UI
               }
           }
       }
    var searchQuery = ""
    
    var createdFoods = [addedFood]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchFoods()

        
    }
    
    func searchFoods() {
        FoodAPIClient.getFoodList(searchQuery: searchQuery) { (result) in
            switch result {
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let foods):
                DispatchQueue.main.async {
                    self.foods = foods
                }
                
            }
        }
        
    }
    
    
    @IBAction func newMealButtonPressed(_ sender: UIButton) {
        
        
        guard let mealName = textFeild.text, !mealName.isEmpty else {
            showAlert(title: "Missing Field", message: "Meal name missing")
            return
        }
        let newItem = addedFood(name: mealName, numberOfCals: 10)
        createdFoods.append(newItem)
        
        // at the end
        showAlert(title: "Meal Added", message: "✅")
        
        dump(createdFoods)

    }
    
}

extension NewItemViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as? FoodCell else {
            fatalError("could not downcast to custom cell")
        }
        let foodItem = foods[indexPath.row]
        cell.configureCell(foodItem: foodItem)
        return cell
    }
    
    
}

extension NewItemViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
