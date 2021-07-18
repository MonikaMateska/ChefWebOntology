//
//  SearchBar.swift
//  ChefWebOntology
//
//  Created by Monika Mateska on 3.7.21.
//

import SwiftUI
 
struct SearchBar: View {
    var placeholer = "Search ..."
    @Binding var text: String
    @State private var isEditing = false
 
    var body: some View {
        HStack {
            TextField(placeholer, text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
 
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
 
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            } else {
                Button(action: {
                    self.isEditing = true
                }) {
                    Image(systemName: "magnifyingglass")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
            
        }
    }
}
