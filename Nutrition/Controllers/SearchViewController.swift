//
//  SearchViewController.swift
//  Nutrition
//
//  Created by Amy Alsaydi on 12/26/19.
//  Copyright © 2019 Amy Alsaydi. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var foods = [Food]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData() // updating UI
            }
        }
    }
    
    let searchQuery = "taco"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchFoods(searchQuery: searchQuery)

    }

    func searchFoods(searchQuery: String) {
        FoodAPIClient.getFoods(searchQuery: searchQuery) { (result) in
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

}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
       
        let food = foods[indexPath.row]
        
        cell.textLabel?.text = food.fields.item_name
        cell.detailTextLabel?.text = food.fields.item_id
        
        return cell
    }
    
    
}
