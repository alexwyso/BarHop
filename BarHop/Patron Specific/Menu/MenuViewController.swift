//
//  MenuViewController.swift
//  BarHop
//
//  Created by Wysoczanski, Alex on 8/6/19.
//  Copyright © 2019 Wysoczanski, Alex. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, HandlePriceEntryDismissProtocol {
    
    var searching = false
    let searchController = UISearchController(searchResultsController: nil)
    
    var allDrinks = [Drink(name: "Aperol Spritz", price: "$8.00"),
                    Drink(name: "Arnold Palmer", price: "$3.50"),
                    Drink(name: "Bacardi Mixed Drink", price: "$9.00"),
                    Drink(name: "Bloody Mary", price: "$9.00"),
                    Drink(name: "Bud Light", price: "$4.00"),
                    Drink(name: "Budweiser", price: "$5.00"),
                    Drink(name: "Corona", price: "$5.00"),
                    Drink(name: "Captain Morgan Mixed Drink", price: "$9.00"),
                    Drink(name: "Champagne", price: "$11.00"),
                    Drink(name: "Dark and Stormy", price: "$11.00")]
    var filteredDrinks = [Drink]()
    
    @IBOutlet weak var table: UITableView!
    
    let dimEffectView = UIView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
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
        
        dimEffectView.backgroundColor = .black
        dimEffectView.frame = view.bounds
        dimEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dimEffectView.alpha = 0
        view.addSubview(dimEffectView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDrinks.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuTableViewCell
        
        cell.drinkNameLabel.text = filteredDrinks[indexPath.row].name
        cell.drinkPriceLabel.text = filteredDrinks[indexPath.row].price
        
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text, searchText.count > 0 {
            
            filteredDrinks = allDrinks.filter({( drink : Drink) -> Bool in
                return drink.name!.lowercased().contains(searchText.lowercased())
            })
            
            table.reloadData()
        } else {
            filteredDrinks = allDrinks
            table.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.dimEffectView.alpha = 0.6
        })
        
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "MenuPopover")
        
        nextViewController.modalPresentationStyle = .overCurrentContext
        if let nextViewController = nextViewController as? MenuPopoverViewController {
            nextViewController.delegate = self
        }
        present(nextViewController, animated: true, completion: nil)
    }
    
    func priceEntryDismissed() {
        UIView.animate(withDuration: 0.5, animations: {
            self.dimEffectView.alpha = 0
        })
    }
}
