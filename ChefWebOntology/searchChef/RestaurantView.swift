//
//  RestaurantView.swift
//  ChefWebOntology
//
//  Created by Monika Mateska on 4.7.21.
//

import SwiftUI

struct RestaurantView: View {
    var restaurant: RestaurantModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                Image("restaurant")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width * 0.9,
                           height: UIScreen.main.bounds.height * 0.3,
                           alignment: .top)
                    .cornerRadius(20)
                    .padding(.top, 8)
                
                Text(restaurant.name)
                    .multilineTextAlignment(.center)
                    .font(.title)
                
                if let country = restaurant.country {
                    HStack {
                        Image(systemName: "mappin")
                            .foregroundColor(.red)
                            .font(.system(size: 23))
                        
                        Text(country)
                            .multilineTextAlignment(.center)
                    }
                }
                
                if let website = restaurant.website,
                   let url = URL(string: website) {
                    Link("View Restaurant Page", destination: url)
                }
                
                Text(restaurant.description)
                    .font(.system(size: 19))
                    .foregroundColor(.gray)
                    .padding()
                
                Spacer()
            }
        }
    }
    
}

struct RestaurantView_Preview: PreviewProvider {
    
    static var previews: some View {
        RestaurantView(restaurant: Mocks.chef.ownerOf[1])
    }
}
