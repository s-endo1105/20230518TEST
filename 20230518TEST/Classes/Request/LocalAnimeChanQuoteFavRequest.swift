//
//  LocalAnimeChanQuoteFavRequest.swift
//  20230518TEST
//
//  Created by ShigeruEndo on 2023/05/18.
//

import Foundation

class LocalAnimeChanQuoteFavRequest {
    static let shared = LocalAnimeChanQuoteFavRequest()
    var database = Database()

    init() {
    }

    func findAnimeChanQuoteFavList() -> [AnimeChanQuote] {
        return database.favDatastore.findAll()
    }

    func findByAnimeAndCharacterAndQuote(anime: String, character: String, quote: String) -> AnimeChanQuote? {
        return database.favDatastore.findByAnimeAndCharacterAndQuote(anime: anime, character: character, quote: quote)
    }

    func insert(anime: String, character: String, quote: String) throws {
        return try database.favDatastore.insert(anime: anime, character: character, quote: quote)
    }

    func delete(id: Int64) throws {
        return try database.favDatastore.delete(targetId: id)
    }
    
    func deleteByAnimeAndCharacterAndQuote(anime: String, character: String, quote: String) throws {
        return try database.favDatastore.deleteByAnimeAndCharacterAndQuote(anime: anime, character: character, quote: quote)
    }
}

