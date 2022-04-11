//
//  ContentModel.swift
//  Tests
//
//  Created by Andres camilo Raigoza misas on 1/03/22.
//

import Foundation
import SwiftUI

@MainActor class ItemListViewModel: ObservableObject {
    @Published private(set) var itemsList = [Item]()
    @Published var loading = true
    
    init() {
        Task {
            let itemsSaved = await DataService.instance.downloadItems()
            await MainActor.run {
                loading = false
                itemsList = itemsSaved
            }
        }
    }
    
    func addItem() {
        withAnimation {
            itemsList.append(Item())
        }
    }
    
    func delete(at offsets: IndexSet) {
        if let index = offsets.first {
            let item = itemsList[index]
            Task {
                await DataService.instance.deleteItem(item: item)
            }
        }
        itemsList.remove(atOffsets: offsets)
    }
    
    func move(fromOffset: IndexSet, toOffset: Int) {
        itemsList.move(fromOffsets: fromOffset, toOffset: toOffset)
    }
    
    func saveItemsToDatabase() {
        print("[😀] Saving to databse \(itemsList.map { $0.name })")
        Task {
            await DataService.instance.uploadItems(items: itemsList)
        }
    }
}
