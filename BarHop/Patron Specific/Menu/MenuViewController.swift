//
//  MenuViewController.swift
//  BarHop
//
//  Created by Wysoczanski, Alex on 8/6/19.
//  Copyright © 2019 Wysoczanski, Alex. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{
    
    var searching = false
    let searchController = UISearchController(searchResultsController: nil)
    
    var allDrinks = [String]()
    var filteredDrinks = [String]()
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        allDrinks.append("Aha")
        allDrinks.append("Oooo")
        allDrinks.append("Bud Light")
        
        filteredDrinks = allDrinks

        navigationController?.navigationBar.prefersLargeTitles = false
        self.title = "Smokey Joe's"
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for Drinks"
        searchController.searchBar.isTranslucent = true
        searchController.dimsBackgroundDuringPresentation = false
        
        navigationController!.navigationBar.tintColor = UIColor.white
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = UIColor.white
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }
        
        // Establish the necessary delegation
        table.delegate = self
        table.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDrinks.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuTableViewCell
        
        cell.drinkNameLabel.text = filteredDrinks[indexPath.row]
        
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text, searchText.count > 0 {
            
            filteredDrinks = allDrinks.filter({( drink : String) -> Bool in
                return drink.lowercased().contains(searchText.lowercased())
            })
            
            table.reloadData()
        }
    }
}
