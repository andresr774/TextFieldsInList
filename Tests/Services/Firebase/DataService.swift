//
//  DataService.swift
//  Tests
//
//  Created by Andres camilo Raigoza misas on 6/04/22.
//

import Foundation
import Firebase

let DB_BASE = Firestore.firestore()

class DataService {
    static let instance = DataService()
    
    private init() { }
    
    private let REF_ITEMS = DB_BASE.collection("items")
    
    func uploadItems(items: [Item]) async {
        for item in items {
            let document = REF_ITEMS.document(item.id)
            
            let itemData: [String: Any] = [
                "name": item.name,
                "price": item.price ?? NSNull(),
                "aisle": item.aisle ?? NSNull()
            ]
            
            do {
                try await document.setData(itemData)
                print("[😀] Item uploaded successfully: \(item.name) ")
            } catch {
                print("[😀] Error uploading item: \(item.name) to database, error: \(error.localizedDescription)")
            }
        }
    }
    
    func downloadItems() async -> [Item] {
        var items = [Item]()
        do {
            let documents = try await REF_ITEMS.getDocuments().documents
            print("[😀] \(documents.count) items downloaded")
            
            if !documents.isEmpty {
                documents.forEach { document in
                    if let name = document.get("name") as? String {
                        let newItem = Item()
                        
                        newItem.id = document.documentID
                        newItem.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
                        newItem.price = document.get("price") as? Double
                        newItem.aisle = document.get("aisle") as? Int
                        
                        items.append(newItem)
                    }
                }
            }
        } catch {
            print("[😀] Error downloading items: \(error.localizedDescription)")
        }
        return items
    }
    
    func deleteItem(item: Item) async {
        let document = REF_ITEMS.document(item.id)
        do {
            try await document.delete()
            print("[😀] Item deleted from database: \(item.name)")
        } catch {
            print("[😀] Error deleting document: \(error.localizedDescription)")
        }
    }
}
