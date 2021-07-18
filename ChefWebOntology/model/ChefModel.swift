//
//  ChefModel.swift
//  ChefWebOntology
//
//  Created by Monika Mateska on 3.7.21.
//

import Foundation

struct ChefModel: Codable {
    let name: String
    let photo: String?
    let birthDate: String?
    let birthPlace: String?
    let website: String
    let ratings: [String]
    let tvShows: [String]
    let ownerOf: [RestaurantModel]
    let cuisines: [CuisineModel]
    let books: [BookModel]
}

struct RestaurantModel: Codable, Hashable {
    let name: String
    let country: String?
    let description: String
    let website: String?
}


struct CuisineModel: Codable, Hashable {
    let name: String
    let chefNames: [String]
    let description: String
}

struct BookModel: Codable, Hashable {
    let name: String
    let description: String
    let website: String?
    let published: String?
}

extension ChefModel {
    static var empty = ChefModel(name: "",
                                 photo: "",
                                 birthDate: "",
                                 birthPlace: "",
                                 website: "",
                                 ratings: [],
                                 tvShows: [],
                                 ownerOf: [],
                                 cuisines: [],
                                 books: [])
}
