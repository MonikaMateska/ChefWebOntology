//
//  CuisineView.swift
//  ChefWebOntology
//
//  Created by Monika Mateska on 4.7.21.
//

import SwiftUI

struct CuisineView: View {
    var cuisine: CuisineModel
    
    var body: some View {
        VStack(spacing: 12) {
            ScrollView {
                Text(cuisine.description)
                    .font(.system(size: 19))
                    .foregroundColor(.gray)
                    .padding(.horizontal)
            }
            .frame(maxHeight: UIScreen.main.bounds.height * 0.3)
            .padding(.vertical)
            
            List {
                Section(header: Text("🧑‍🍳 Chefs with \(cuisine.name) style")) {
                    ForEach(cuisine.chefNames, id: \.self) {
                        Text($0)
                    }
                }
            }
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("🍴 " + cuisine.name)
    }
    
}

struct CuisineView_Preview: PreviewProvider {
    
    static var previews: some View {
        CuisineView(cuisine: Mocks.chef.cuisines[1])
    }
}
