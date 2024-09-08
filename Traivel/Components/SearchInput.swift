//
//  SearchInput.swift
//  Traivel
//
//  Created by Daria on 31.5.2024.
//

import SwiftUI

struct SearchInput<T: Hashable>: View {
    @Binding var selectedItem: T?
    @Binding var showSheet: Bool
    
    var items: [T]
    var filterItems: (_: String, _: [T]) -> [T]
    var generateLabel: (_: T) -> String
    var placeholder: String
    
    @State var searchPrompt = ""
    @State var filteredItems: [T] = []
    @FocusState private var focusedField: FocusField?
    
    enum FocusField: Hashable {
        case searchField
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField(placeholder, text: $searchPrompt).onChange(of: searchPrompt, {
                    filteredItems = filterItems(searchPrompt, items)
                })
                .autocorrectionDisabled()
                .focused($focusedField, equals: .searchField)
                .onAppear {
                    self.focusedField = .searchField
                }
                Spacer()
                if !searchPrompt.isEmpty {
                    Button(action: { searchPrompt = "" }) {
                        Image(systemName: "x.circle.fill")
                    }
                    .foregroundColor(.secondary)
                }
            }
                
            if !filteredItems.isEmpty {
                ForEach(filteredItems, id: \.self) { item in
                    Divider()
                        .padding(.top)
                        .padding(.bottom)
                    Button(action: {
                        selectedItem = item
                        showSheet = false
                    }) {
                        Text(generateLabel(item))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }.buttonStyle(.plain)
                }
                
                
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(.regularMaterial))
        .animation(.snappy, value: filteredItems)
        .animation(.snappy, value: searchPrompt)
    }
}
