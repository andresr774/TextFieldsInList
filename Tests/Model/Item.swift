//
//  Item.swift
//  Tests
//
//  Created by Andres camilo Raigoza misas on 1/03/22.
//

import Foundation

struct Item: Hashable {
    let name: String
    let price: Double?
    let aisle: Int?
    
    func updatePrice(updatedPrice: Double?) -> Item {
        Item(name: name, price: updatedPrice, aisle: aisle)
    }
    func updateAisle(updatedAisle: Int?) -> Item {
        Item(name: name, price: price, aisle: updatedAisle)
    }
}
