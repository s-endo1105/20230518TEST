//
//  AnimeChanQuoteListViewModel.swift
//  20230518TEST
//
//  Created by ShigeruEndo on 2023/05/18.
//

import Foundation

class AnimeChanQuoteListViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var canLoadMore: Bool = false
    @Published var quoteList: [AnimeChanQuote] = []
    @Published var searchTitle: String = ""
    
    var currentPage: Int = 0
    private let animeChanRepository: AnimeChanRepositoryProtocol

    init(animeChanRepository: AnimeChanRepositoryProtocol = AnimeChanRepository()) {
        self.animeChanRepository = animeChanRepository
        currentPage = quoteList.count > 0 ? quoteList.count / 10 : 0
        fetchAnimeChanQuote()
    }

    func checkDesplayScrollBottomCell(displayQuote: AnimeChanQuote) -> Bool {
        guard let lastAnimeChanQuote = self.quoteList.last else { return false }
        if displayQuote.id! == lastAnimeChanQuote.id! {
            return true
        }
        return false
    }
    
    func fetchAnimeChanQuote(isLoadMore: Bool = false) {
        guard !isLoading else { return }
        self.isLoading = true
        let page = (quoteList.count > 0) ? currentPage + 1 : 0
        animeChanRepository.fetchAnimeChanQuote(page: page) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case let .success(response):
                if !response.isEmpty {
                    let responseQuoteIndexList = convertAnimeChanQuoteIndexList(responseQuoteList: response)
                    self.quoteList = isLoadMore ? self.quoteList + responseQuoteIndexList : responseQuoteIndexList
                    self.currentPage += 1
                }
            case let .failure(error):
                print(error)
            }
        }
    }

    func tappedSearchBtn() {
        guard !isLoading else { return }
        if searchTitle.isEmpty { return }
        // ボタン押下時にはリストを初期化
        quoteList = []
        fetchAnimeChanQuoteTitle()
    }

    func tappedClearSearchTitleBtn() {
        self.searchTitle = ""
        // 検索結果もクリア
        quoteList = []
    }

    func fetchAnimeChanQuoteTitle(isLoadMore: Bool = false) {
        guard !isLoading else { return }
        self.isLoading = true

        let page = (quoteList.count > 0) ? currentPage + 1 : 0
        animeChanRepository.fetchAnimeChanQuoteTitle(anime: self.searchTitle, page: page) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case let .success(response):
                if !response.isEmpty {
                    let responseQuoteIndexList = convertAnimeChanQuoteIndexList(responseQuoteList: response)
                    self.quoteList = isLoadMore ? self.quoteList + responseQuoteIndexList : responseQuoteIndexList
                    self.currentPage += 1
                }
            case let .failure(error):
                print(error)
            }
        }
    }

    //TODO. レスポンスにIDが存在しないため、リスト出力用に一時的なIDをふる(デコードして作ったEntityをコピーし直すというちょっと効率の悪いことをしている)
    func convertAnimeChanQuoteIndexList(responseQuoteList: [AnimeChanQuote]) -> [AnimeChanQuote] {
        var responseQuoteIndexList: [AnimeChanQuote] = []
        var animeChanQuoteId = quoteList.count
        for animeChanQuote in responseQuoteList {
            var copyAnimeChanQuote = animeChanQuote
            if animeChanQuoteId == 0 {
                copyAnimeChanQuote.id = 0
            } else {
                copyAnimeChanQuote.id = animeChanQuoteId
            }
            animeChanQuoteId += 1
            responseQuoteIndexList.append(copyAnimeChanQuote)
        }
        return responseQuoteIndexList
    }

    //TODO.Routerを実装したいが時間がないので余ったら実装予定
    func detailScreenTransition(animeChanQuote: AnimeChanQuote) {
        
    }
}
