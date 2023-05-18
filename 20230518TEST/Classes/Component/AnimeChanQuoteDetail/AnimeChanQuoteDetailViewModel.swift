//
//  AnimeChanQuoteDetailViewModel.swift
//  20230518TEST
//
//  Created by ShigeruEndo on 2023/05/18.
//

import Foundation

class AnimeChanQuoteDetailViewModel: ObservableObject {
    
    @Published var isFavorite: Bool = false
    @Published var isLoading: Bool = false

    private let animeChanRepository: LocalAnimeChanRepositoryProtocol
    private var findAnimeChanQuote: AnimeChanQuote?
    
    var buttonText: String {
        self.isFavorite ? "お気に入り削除" : "お気に入り追加"
    }
    
    init(animeChanRepository: LocalAnimeChanRepositoryProtocol = LocalAnimeChanRepository()) {
        self.animeChanRepository = animeChanRepository
    }

    func fetchLocalFavorite(animeChanQuote: AnimeChanQuote) {
        self.isFavorite = false
        let quote = animeChanRepository.fetchLocalFavAnimeChanQuotes(anime: animeChanQuote.anime, character: animeChanQuote.character, quote: animeChanQuote.quote)
        if quote != nil {
            findAnimeChanQuote = quote
            self.isFavorite = true
        } else {
            self.isFavorite = false
        }
    }

    func updateFavorite(animeChanQuote: AnimeChanQuote) {
        do {
            if self.isFavorite {
                // 削除
                try animeChanRepository.deleteByAnimeAndCharacterAndQuote(anime: animeChanQuote.anime, character: animeChanQuote.character, quote: animeChanQuote.quote)
            } else {
                // 追加
                try animeChanRepository.insert(anime: animeChanQuote.anime, character: animeChanQuote.character, quote: animeChanQuote.quote)
            }
        } catch {
            print(error)
            return
        }
        self.isFavorite = !self.isFavorite
    }
}
