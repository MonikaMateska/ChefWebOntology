//
//  ContentView.swift
//  ChefWebOntology
//
//  Created by Monika Mateska on 3.7.21.
//

import SwiftUI

struct ContentView: View {
    @State var chef = ChefModel.empty
    @State var searchText = ""
    @State var loading = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Chef Web Ontology")
                    .font(.title)
                    .bold()
                    .padding([.top, .horizontal])
                    .padding(.bottom, 4)
                Spacer()
            }
            
            SearchBar(placeholer: "Search your chef...", text: $searchText)
            
            LoadingView(isShowing: $loading) {
                NavigationView {
                    chefInformation
                        .offset(y: -55)
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onReceive(NotificationCenter
                    .default
                    .publisher(for: UIResponder.keyboardDidHideNotification)) { _ in
            searchChef()
        }
    }
    
    var chefInformation: some View {
        VStack(spacing: 3) {
            if let photo = chef.photo,
               let photoUrl = URL(string: photo) {
                AsyncImage(url: photoUrl,
                           placeholder: { Text(nameInitials) },
                           image: { Image(uiImage: $0).resizable() })
                    .scaledToFill()
                    .frame(maxWidth: 150, maxHeight: 150)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .overlay(Circle().stroke(Color.black, lineWidth: 1))
            } else if !chef.name.isEmpty {
                Text(nameInitials)
                    .scaledToFill()
                    .frame(maxWidth: 150, maxHeight: 150)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .overlay(Circle().stroke(Color.black, lineWidth: 1))
            }
            
            Text(chef.name)
                .bold()
                .font(.system(size: 21))
                .padding(.bottom)
            
            Form {
                if !chef.name.isEmpty {
                    generalInformation
                }
                if !chef.ratings.isEmpty {
                    ratings
                }
                if !chef.ownerOf.isEmpty {
                    restaurants
                }
                if !chef.books.isEmpty {
                    books
                }
                if !chef.cuisines.isEmpty {
                    cuisines
                }
                if !chef.tvShows.isEmpty {
                    tvShows
                }
            }
        }
    }
    
    var nameInitials: String {
        return chef.name
            .components(separatedBy: .whitespacesAndNewlines)
            .reduce("") { "\($0)" + "\($1.first ?? ".")" }
    }
    
    var generalInformation: some View {
        Section(header: Text("General Information")) {
            if let birthDate = chef.birthDate {
                HStack {
                    Text("Birth Date")
                        .bold()
                    Spacer()
                    Text(birthDate)
                }
            }
            
            if let birthPlace = chef.birthPlace {
                HStack {
                    Text("Hometown")
                        .bold()
                    Spacer()
                    Text(birthPlace)
                }
            }
            
            if let website = chef.website,
               let url = URL(string: website) {
                HStack {
                    Text("Website")
                        .bold()
                    Spacer()
                    Link(website, destination: url)
                        .font(.system(size: 12))
                }
            }
        }
    }
    
    var ratings: some View {
        Section(header: Text("Ratings")) {
            List(chef.ratings, id:\.self) { rating in
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(rating)
                }
            }
        }
    }
    
    var restaurants: some View {
        Section(header: Text("Restaurants")) {
            List(chef.ownerOf, id:\.self) { restaurant in
                NavigationLink(
                    destination: RestaurantView(restaurant: restaurant),
                    label: {
                        Text(restaurant.name)
                            .foregroundColor(.primary)
                    })
            }
        }
        
    }
    
    var books: some View {
        Section(header: Text("Books")) {
            List(chef.books.indices) { index in
                NavigationLink(
                    destination: BookView(chef: chef, index: index),
                    label: {
                        Text(chef.books[index].name)
                            .foregroundColor(.primary)
                    })
            }
        }
    }
    
    var cuisines: some View {
        Section(header: Text("Cuisines")) {
            List(chef.cuisines, id:\.self) { cuisine in
                NavigationLink(
                    destination: CuisineView(cuisine: cuisine),
                    label: {
                        Text(cuisine.name)
                            .foregroundColor(.primary)
                    })
            }
        }
    }
    
    var tvShows: some View {
        Section(header: Text("TV Shows")) {
            List(chef.tvShows.filter { !$0.isEmpty }, id:\.self) { tvShow in
                Text(tvShow)
            }
        }
    }
    
    // MARK: - private
    
    private func searchChef() {
        guard !searchText.isEmpty else {
            return
        }
        let nameQuery = searchText.replacingOccurrences(of: " ", with: "_")
        let path = "http://localhost:8080/api/chef/\(nameQuery)"
        guard let url = URL(string: path) else {
            return
        }
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        loading = true
        chef = ChefModel.empty
        print("API Request \(request)")
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard error == nil,
                  let data = data else { return }
            
            loading = false
            let decoder = JSONDecoder()
            do {
                chef = try decoder.decode(ChefModel.self, from: data)
            }
            catch {
                chef = ChefModel.empty
                print("Error in JSON parsing.")
            }
        }
        
        dataTask.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
