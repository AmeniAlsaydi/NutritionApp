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
    
    var searchQuery = "" {
        didSet {
            DispatchQueue.main.async {
                self.searchFoods()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
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

}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
       
        let food = foods[indexPath.row]
        
        cell.textLabel?.text = food.fields.item_name
        cell.detailTextLabel?.text = "\(food.fields.brand_name)"
        
        return cell
    }
    
    
}

extension SearchViewController: UISearchBarDelegate {
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

