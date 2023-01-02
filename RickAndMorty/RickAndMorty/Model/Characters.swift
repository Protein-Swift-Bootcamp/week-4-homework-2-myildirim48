//
//  Characters.swift
//  RickAndMorty
//
//  Created by YILDIRIM on 28.12.2022.
//

import Foundation

// MARK: - Welcome
struct Characters: Codable {
    let info: CharInfo
    let results: [CharResult]
}
// MARK: - Info
struct CharInfo: Codable {
    let count, pages: Int
}
// MARK: - Result
struct CharResult: Codable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: Gender
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}
// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

