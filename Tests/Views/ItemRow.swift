//
//  ItemRow.swift
//  Tests
//
//  Created by Andres camilo Raigoza misas on 1/03/22.
//

import SwiftUI

struct ItemRow: View {
    @ObservedObject var vm: ItemListViewModel
    let item: Item
    let index: Int
    @FocusState var fieldInFocus: InputField?
    @State private var price: Double?
    @State private var aisle: Int?
        
    var body: some View {
        HStack(spacing: 20) {
            Text(item.name)
            TextField("Price...", value: $price, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                .focused($fieldInFocus, equals: .price)
                .padding(10)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(12)
                .keyboardType(.decimalPad)
                .onChange(of: price) { _ in
                    vm.updatePrice(index: index, price: price)
                }
                
            Spacer()
            
            TextField("Aisle...", value: $aisle, format: .number)
                .focused($fieldInFocus, equals: .aisle)
                .padding(10)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(12)
                .keyboardType(.numberPad)
                .onChange(of: aisle) { _ in
                    vm.updateAisle(index: index, aisle: aisle)
                }
        }
        .onChange(of: vm.itemsList) { _ in
            updateTextFieldsValues()
        }
    }
    func updateTextFieldsValues() {
        guard index < vm.itemsList.count else { return }
        
        if price != vm.itemsList[index].price ||
            aisle != vm.itemsList[index].aisle {
            
            fieldInFocus = nil
            price = vm.itemsList[index].price
            aisle = vm.itemsList[index].aisle
            print("Updated on index: \(index), price text field: \(String(describing: price)) and aisle text field: \(String(describing: aisle))")
        }
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(vm: ItemListViewModel(), item: Item(name: "Apple", price: nil, aisle: nil), index: 0)
    }
}
