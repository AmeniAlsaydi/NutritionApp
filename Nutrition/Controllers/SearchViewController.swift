//
//  SearchViewController.swift
//  Nutrition
//
//  Created by Amy Alsaydi on 12/26/19.
//  Copyright © 2019 Amy Alsaydi. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    enum SearchScope {
        case database
        case custom
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var foods = [Food]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData() // updating UI
            }
        }
    }
    
    var customFoods = [addedFood]()
    
    var currentScope = SearchScope.database
    
    var searchQuery = "" {
        didSet {
            switch currentScope {
            case .database:
                DispatchQueue.main.async {
                    self.searchFoods()
                }
            case .custom:
                // here is where I have to get to the local data.
                // i think i could leave this as is and just edit the search food to switch on scope
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        searchFoods()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController, let indexpath = tableView.indexPathForSelectedRow else {
            fatalError("couldnt get detailVC or indexPath")
        }
        
        detailVC.selectedFood = foods[indexpath.row]
    }

    func searchFoods() {
        
        switch currentScope {
        case .database:
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
        case .custom:
            customFoods = NewItemViewController.createdFoods
            }
        }
        

}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentScope {
        case .database:
            return foods.count
        case .custom:
            return customFoods.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
       
        
        
        switch currentScope {
        case .database:
            let food = foods[indexPath.row]
            
            cell.textLabel?.text = food.fields.item_name.capitalized
            cell.detailTextLabel?.text = food.fields.brand_name
        case .custom:
            let food = customFoods[indexPath.row]
            
            cell.textLabel?.text = food.name
            cell.detailTextLabel?.text = food.numberOfCals?.description
        }
        
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
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            currentScope = .database
        case 1:
            currentScope = .custom
        default:
            print("not a valid search scope")
        }
    }
    }

