//
//  ContentView.swift
//  Tests
//
//  Created by Andres camilo Raigoza misas on 1/03/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm: ItemListViewModel
    @FocusState private var fieldInFocus: InputField?
    
    var body: some View {
        NavigationView {
            VStack {
                if vm.loading {
                    downloading
                } else {
                    if vm.itemsList.isEmpty {
                        emptyList
                    } else {
                        listOfItems
                    }
                }
            }
            .navigationTitle("Items")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        vm.addItem()
                    } label: {
                        Image(systemName: "plus")
                            .font(.headline)
                    }
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    doneButton
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: ItemListViewModel())
    }
}

extension ContentView {
    private var listOfItems: some View {
        List {
            ForEach(vm.itemsList) {
                ItemRow(item: $0, fieldInFocus: $fieldInFocus)
                    .listRowInsets(.init(top: 15, leading: 15, bottom: 15, trailing: 15))
            }
            .onDelete(perform: vm.delete)
            .onMove(perform: vm.move)
        }
        .listStyle(.plain)
    }
    
    private var emptyList: some View {
        VStack(spacing: 10) {
            Text("🙁")
                .font(.system(size: 50))
            
            Text("You have not created any Item yet. Please tap \"")
            + Text("+")
                .font(.title2.weight(.semibold))
            + Text("\" to add one.")
            
            Spacer()
        }
        .padding()
    }
    
    private var downloading: some View {
        Text("Downloading Items...")
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding()
    }
    
    private var doneButton: some View {
        Button("Done") {
            fieldInFocus = nil
        }
    }
}


