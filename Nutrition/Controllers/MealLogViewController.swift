//
//  MealLogViewController.swift
//  Nutrition
//
//  Created by Amy Alsaydi on 1/1/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class MealLogViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var meals = [[LoggedFood]]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadMeals()

        
    }
    
    func loadMeals() {
        meals = LoggedFood.sectionMeal()
    }

}

extension MealLogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath)
        
        let meal = meals[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = meal.name
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return meals[section].first?.meal.rawValue.capitalized
    }
    
}
