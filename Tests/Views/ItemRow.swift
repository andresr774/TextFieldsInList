//
//  ItemRow.swift
//  Tests
//
//  Created by Andres camilo Raigoza misas on 1/03/22.
//

import SwiftUI

struct ItemRow: View {
    @State var item: Item
    var fieldInFocus: FocusState<InputField?>.Binding
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text("Name: ")
                TextField("New Item", text: $item.name)
                    .focused(fieldInFocus, equals: .name)
                    .font(.headline)
                    .defaultTextField()
            }
            
            HStack(spacing: 20) {
                Text("Price:")
                TextField("$0.00",
                          value: $item.price,
                          format: .currency(code: Locale.current.currencyCode ?? "USD")
                )
                .focused(fieldInFocus, equals: .price)
                .defaultTextField()
                .keyboardType(.decimalPad)
                
                Spacer(minLength: 0)
                
                Text("Aisle:")
                TextField("1", value: $item.aisle, format: .number)
                    .focused(fieldInFocus, equals: .aisle)
                    .defaultTextField()
                    .keyboardType(.numberPad)
            }
        }
    }
}

struct ItemRow_Previews: PreviewProvider {
    @FocusState static var fieldInFocus: InputField?
    
    static var previews: some View {
        ItemRow(item: Item(), fieldInFocus: $fieldInFocus)
    }
}
