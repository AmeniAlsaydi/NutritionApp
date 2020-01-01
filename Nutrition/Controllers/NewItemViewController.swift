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
    var searchQuery = ""  {
        didSet {
            DispatchQueue.main.async {
                self.searchFoods()
            }
        }
    }
    
    
    static var createdFoods = [addedFood]() // i made this static so i can try and reference them in another vc ???
    var ingredients = [Food]()
    var newMeal: addedFood?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchFoods()
        searchBar.delegate = self
        
        
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
    
    func getNumCals(ingredients: [Food],completion: @escaping (Result<Double, AppError>)-> ()) {
        var numOfCals: Double = 0
        let group = DispatchGroup() // group tasks for  asynchronous execution, When all work items finish executing, the group executes its completion handler.
        
        // https://www.reddit.com/r/iOSProgramming/comments/7srwon/completion_handler_is_called_before_loop_is/
        
        // apple doc: https://developer.apple.com/documentation/dispatch/dispatchgroup
        
        for ingredient in ingredients {
            group.enter()
            FoodAPIClient.getFoodInfo(itemID: ingredient.fields.item_id) { (result) in
                switch result {
                case .failure(let appError):
                    print("appError: \(appError)")
                    completion(.failure(.networkClientError(appError)))
                case .success(let foodInfo):
                    numOfCals += foodInfo.nf_calories ?? 0
                    //completion(.success(numOfCals)) //  without dispatchgrup if here multiple dishes are added based on the number of ingredients
                    
                }
              group.leave()
            }
        }
        group.wait()
        completion(.success(numOfCals)) // without dispatchgrup if here the num cals are not calculated
    }
    
    @IBAction func createNewPressed(_ sender: Any) {
        textFeild.text = nil
        ingredients = [Food]() // empties out foods
        dump(NewItemViewController.createdFoods)
        print(NewItemViewController.createdFoods.count)
    }
    
    @IBAction func newMealButtonPressed(_ sender: UIButton) {
        
        guard let mealName = textFeild.text, !mealName.isEmpty else {
            showAlert(title: "Missing Field", message: "Meal name missing")
            return
        }
        var numCals = 0.0
        
        getNumCals(ingredients: ingredients) { (result) in
            switch result {
            case .failure(let appError):
                print("here: \(appError)")
            case .success(let returnednumCals):
                print(returnednumCals) // this has
                numCals = returnednumCals
                self.newMeal = addedFood(name: mealName, ingredients: self.ingredients, numberOfCals: numCals)
                guard let newMeal = self.newMeal else {
                    fatalError("no newMeal")
                }
                
                NewItemViewController.createdFoods.append(newMeal)
                
            }
        }
        
        // at the end
        showAlert(title: "\(mealName) added", message: "✅ 😋 ✅")
        
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

extension NewItemViewController: UISearchBarDelegate {
func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
        
        guard let searchText = searchBar.text else {
            return
        }
        
        guard !searchText.isEmpty else {
            searchFoods()
            return
        }
        
        searchQuery = searchText.lowercased().addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "no"
        
    }
}

// NOTES:

// I think I could calulate the number of Calories by mapping through the [Food] -> this might not work because cal info is in the FoodInfo
// Do I need to create another tab to show the list of the created foods the user adds? or should it be saved/posted to a seperate api?
