//
//  AnimeChanQuote.swift
//  20230518TEST
//
//  Created by ShigeruEndo on 2023/05/18.
//

struct AnimeChanQuote: Codable, Identifiable, Equatable {
    var id: Int?
    let anime: String
    let character: String
    let quote: String

    init(anime: String, character: String, quote: String) {
        self.anime = anime
        self.character = character
        self.quote = quote
    }

    init(id: Int, anime: String, character: String, quote: String) {
        self.id = id
        self.anime = anime
        self.character = character
        self.quote = quote
    }
}
