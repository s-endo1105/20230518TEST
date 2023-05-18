//
//  AnimeChanQuoteFavListViewModel.swift
//  20230518TEST
//
//  Created by ShigeruEndo on 2023/05/18.
//

import Foundation

class AnimeChanQuoteFavListViewModel: ObservableObject {
    
    @Published var favList: [AnimeChanQuote] = []

    private let animeChanRepository: LocalAnimeChanRepositoryProtocol
    
    init(animeChanRepository: LocalAnimeChanRepositoryProtocol = LocalAnimeChanRepository()) {
        self.animeChanRepository = animeChanRepository
    }

    func fetchLoaclFavAnimeChanFavList() {
        self.favList = self.animeChanRepository.fetchLocalAnimeChanQuoteFavAll()
    }

    func deleteAnimeChanQuote(animeChanQuote: AnimeChanQuote) {
        do {
            try animeChanRepository.deleteByAnimeAndCharacterAndQuote(anime: animeChanQuote.anime, character: animeChanQuote.character, quote: animeChanQuote.quote)
        } catch {
            print(error)
            return
        }
        self.fetchLoaclFavAnimeChanFavList()
    }
}
