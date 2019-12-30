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
    var searchQuery = "" // TODO: fix search bar
    
    
    static var createdFoods = [addedFood]() // i made this static so i can reference them in another vc ???
    var ingredients = [Food]()
    var newMeal: addedFood?
    
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
    
    func getNumCals(ingredients: [Food]) -> Double {
        var numOfCals: Double = 0
        
        for ingredient in ingredients {
            FoodAPIClient.getFoodInfo(itemID: ingredient.fields.item_id) { (result) in
                switch result {
                case .failure(let appError):
                    print("appError: \(appError)")
                case .success(let foodInfo):
                    numOfCals += foodInfo.nf_calories ?? 0
                }
            }
        }
        return numOfCals
    }
    
    
    @IBAction func newMealButtonPressed(_ sender: UIButton) {
        
        guard let mealName = textFeild.text, !mealName.isEmpty else {
            showAlert(title: "Missing Field", message: "Meal name missing")
            return
        }
        newMeal = addedFood(name: mealName, ingredients: ingredients, numberOfCals: getNumCals(ingredients: ingredients))
        
        NewItemViewController.createdFoods.append(newMeal!) // I force unwrapped this.. feels dangerous
        
        // at the end
        showAlert(title: "Meal Added", message: "✅")
        
        dump(NewItemViewController.createdFoods)
        ingredients = [Food]() // empties out foods
        
        //TO DO: Re-enable the add buttons for the cell once a new meal has been created
        
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
        cell.delegate = self
        return cell
    }
}

extension NewItemViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension NewItemViewController: FoodCellDelegate {
    func didAddItem(ingredient: Food) {
        ingredients.append(ingredient)
        //dump(ingredients)
    }
}

// NOTES:

// I think I could calulate the number of Calories but mapping through the [Food] -> this might not work because cal info is in the FoodInfo
// Do I need to create another tab to show the list of the created foods the user adds? or should it be saved/posted to a seperate api?
