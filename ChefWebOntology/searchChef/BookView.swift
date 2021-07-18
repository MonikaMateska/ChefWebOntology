//
//  BookView.swift
//  ChefWebOntology
//
//  Created by Monika Mateska on 4.7.21.
//

import SwiftUI

struct BookView: View {
    var chef: ChefModel
    var index: Int
    
    var body: some View {
        VStack(spacing: 12) {
            Image("chefCooking")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width * 0.9,
                       height: UIScreen.main.bounds.height * 0.3,
                       alignment: .top)
                .cornerRadius(20)
                .padding(.top, 8)
            
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    Text("🏷 " + chef.name)
                        .foregroundColor(.gray)
                    
                    if let published = book.published {
                        HStack {
                            Text("🗓 Published on \(published)")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    if let website = book.website,
                       let url = URL(string: website) {
                        Link("View Book Page", destination: url)
                    }
                    
                }
                .padding(.horizontal)
                
                Spacer()
            }

            
            List {
                Section(header: Text("Description")) {
                    Text(book.description)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(book.name)
    }
    
    var book: BookModel {
        return chef.books[index]
    }
}

struct BookView_Preview: PreviewProvider {
    
    static var previews: some View {
        BookView(chef: Mocks.chef, index: 0)
    }
}
