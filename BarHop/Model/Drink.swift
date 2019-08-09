//
//  Drink.swift
//  BarHop
//
//  Created by Wysoczanski, Alex on 8/8/19.
//  Copyright © 2019 Wysoczanski, Alex. All rights reserved.
//

import Foundation

struct Drink: Codable {

    let name: String?
    let price: String?
    
    init (name: String, price: String) {
        self.name = name
        self.price = price
    }
}
