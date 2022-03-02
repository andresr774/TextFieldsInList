//
//  ContentModel.swift
//  Tests
//
//  Created by Andres camilo Raigoza misas on 1/03/22.
//

import Foundation
import SwiftUI

class ItemListViewModel: ObservableObject {
    @Published var itemsList = [Item]()
    @Published var name = ""
    
    func addItem() {
        guard name != "" else { return }
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let newItem = Item(name: trimmedName, price: nil, aisle: nil)
        withAnimation {
            itemsList.append(newItem)
        }
        name = ""
    }
    
    func updatePrice(index: Int, price: Double?) {
        let updatedItem = itemsList[index].updatePrice(updatedPrice: price)
        itemsList[index] = updatedItem
        print("Updated price: \(updatedItem)")
    }
    
    func updateAisle(index: Int, aisle: Int?) {
        let updatedItem = itemsList[index].updateAisle(updatedAisle: aisle)
        itemsList[index] = updatedItem
        print("Updated aisle: \(updatedItem)")
    }
    
    func delete(at offsets: IndexSet) {
        itemsList.remove(atOffsets: offsets)
    }
    
    func move(fromOffset: IndexSet, toOffset: Int) {
        itemsList.move(fromOffsets: fromOffset, toOffset: toOffset)
    }
    
    func saveToDatabase() {
        print("Saving to databse \(itemsList)")
    }
}
