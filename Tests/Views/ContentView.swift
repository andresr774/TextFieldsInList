//
//  ContentView.swift
//  Tests
//
//  Created by Andres camilo Raigoza misas on 1/03/22.
//

import SwiftUI

enum InputField: Hashable {
    case text, price, aisle
}

struct ContentView: View {
    @StateObject private var vm = ItemListViewModel()
    @FocusState var fieldInFocus: InputField?
    
    var body: some View {
        NavigationView {
            VStack {
                addItemView
                listOfItems
                saveButton
            }
            .navigationTitle("Items")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        if fieldInFocus == .text {
                            vm.addItem()
                        }
                        fieldInFocus = nil
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    private var addItemView: some View {
        HStack(spacing: 20) {
            TextField("Item...", text: $vm.name)
                .focused($fieldInFocus, equals: .text)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .padding(.horizontal)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(15)
                .onSubmit {
                    vm.addItem()
                }
        }
        .padding()
    }
    private var listOfItems: some View {
        List {
            ForEach(vm.itemsList.indices, id: \.self) { index in
                ItemRow(
                    vm: vm,
                    item: vm.itemsList[index],
                    index: index,
                    fieldInFocus: _fieldInFocus
                )
            }
            .onDelete(perform: vm.delete)
            .onMove(perform: vm.move)
        }
        .listStyle(.plain)
    }
    private var saveButton: some View {
        Button {
            vm.saveToDatabase()
        } label: {
            Text("Save to database")
                .font(.headline)
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
    }
}


