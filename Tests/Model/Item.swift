//
//  Item.swift
//  Tests
//
//  Created by Andres camilo Raigoza misas on 1/03/22.
//

import Foundation

class Item: Identifiable {
    var id = UUID().uuidString
    var name = ""
    var price: Double?
    var aisle: Int?
}

enum InputField: Hashable {
    case name, price, aisle
}
