//
//  AnimeChanRepository.swift
//  20230518TEST
//
//  Created by ShigeruEndo on 2023/05/18.
//

import Foundation

protocol AnimeChanRepositoryProtocol: AnyObject {
    func fetchAnimeChanQuote(
        page: Int,
        completion: @escaping (Result<[AnimeChanQuote], Error>) -> Void
    )
    func fetchAnimeChanQuoteTitle(
        anime: String,
        page: Int,
        completion: @escaping (Result<[AnimeChanQuote], Error>) -> Void
    )
}

protocol LocalAnimeChanRepositoryProtocol: AnyObject {
    func fetchLocalAnimeChanQuoteFavAll() -> [AnimeChanQuote]
    func fetchLocalFavAnimeChanQuotes(
        anime: String,
        character: String,
        quote: String
    ) -> AnimeChanQuote?
    func insert(anime: String, character: String, quote: String) throws
    func deleteById(id: Int64) throws
    func deleteByAnimeAndCharacterAndQuote(anime: String, character: String, quote: String) throws
}


final class AnimeChanRepository: AnimeChanRepositoryProtocol  {
    func fetchAnimeChanQuote(
        page: Int,
        completion: @escaping (Result<[AnimeChanQuote], Error>) -> Void
    ) {
        let request = AnimeChanQuoteRequest(component: AnimeChanQuoteRequest.Component(page: page))
        APIClient.shared.sendRequest(request) { result in
            completion(result)
        }
    }
    func fetchAnimeChanQuoteTitle(
        anime: String,
        page: Int,
        completion: @escaping (Result<[AnimeChanQuote], Error>) -> Void
    ) {
        let request = AnimeChanQuoteTitleRequest(component: AnimeChanQuoteTitleRequest.Component(title: anime, page: page))
        APIClient.shared.sendRequest(request) { result in
            completion(result)
        }
    }
}

final class LocalAnimeChanRepository: LocalAnimeChanRepositoryProtocol  {
    func fetchLocalAnimeChanQuoteFavAll() -> [AnimeChanQuote] {
        return LocalAnimeChanQuoteFavRequest.shared.findAnimeChanQuoteFavList()
    }

    func fetchLocalFavAnimeChanQuotes(
        anime: String,
        character: String,
        quote: String
    ) -> AnimeChanQuote? {
        return LocalAnimeChanQuoteFavRequest.shared.findByAnimeAndCharacterAndQuote(anime: anime, character: character, quote: quote)
    }
    
    func insert(anime: String, character: String, quote: String) throws {
        try LocalAnimeChanQuoteFavRequest.shared.insert(anime: anime, character: character, quote: quote)
    }
    func deleteById(id: Int64) throws {
        try LocalAnimeChanQuoteFavRequest.shared.delete(id: id)
    }
    func deleteByAnimeAndCharacterAndQuote(anime: String, character: String, quote: String) throws {
        try LocalAnimeChanQuoteFavRequest.shared.deleteByAnimeAndCharacterAndQuote(anime: anime, character: character, quote: quote)
    }
}
