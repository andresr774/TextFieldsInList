//
//  Item.swift
//  Tests
//
//  Created by Andres camilo Raigoza misas on 1/03/22.
//

import Foundation

struct Item: Identifiable, Equatable {
    var id = UUID().uuidString
    let name: String
    let price: Double?
    let aisle: Int?
    
    func updatePrice(updatedPrice: Double?) -> Item {
        Item(id: id, name: name, price: updatedPrice, aisle: aisle)
    }
    func updateAisle(updatedAisle: Int?) -> Item {
        Item(id: id, name: name, price: price, aisle: updatedAisle)
    }
}

enum InputField: Hashable {
    case name, price, aisle
}
