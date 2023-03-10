//
//  Episodes.swift
//  RickAndMorty
//
//  Created by YILDIRIM on 28.12.2022.
//
import Foundation

// MARK: - Episodes
struct Episodes: Codable {
    let results: [ResultEpisode]
}
// MARK: - Result
struct ResultEpisode: Codable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}
