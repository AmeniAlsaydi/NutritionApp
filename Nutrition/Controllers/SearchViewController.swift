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
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var currentSegmentIndex: Int = 0
    
    var foods = [Food]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData() // updating UI
            }
        }
    }
    
    var customFoods = [addedFood]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    //var currentScope = SearchScope.database
    
    var searchQuery = "" {
        didSet {
            DispatchQueue.main.async {
                self.searchFoods()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
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
       
            customFoods = NewItemViewController.createdFoods
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        currentSegmentIndex = sender.selectedSegmentIndex // valid values 0, 1
        tableView.reloadData()

    }
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentSegmentIndex {
        case 0:
            return foods.count
        case 1:
            return customFoods.count
        default:
            return 0
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        
        switch currentSegmentIndex {
        case 0:
            let food = foods[indexPath.row]
            
            cell.textLabel?.text = food.fields.item_name.capitalized
            cell.detailTextLabel?.text = food.fields.brand_name
        case 1:
            // never comes in here even once the currentScope is custom ???? 
            let food = customFoods[indexPath.row]

            cell.textLabel?.text = food.name
            cell.detailTextLabel?.text = food.numberOfCals?.description
        default:
            fatalError("Issue here")
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
    
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

