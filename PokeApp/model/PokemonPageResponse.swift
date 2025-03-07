//
//  Untitled.swift
//  PokeApp
//
//  Created by MacBookTicsInplanet on 6/3/25.
//


struct PokemonPageResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [AbilityResponse]
}

