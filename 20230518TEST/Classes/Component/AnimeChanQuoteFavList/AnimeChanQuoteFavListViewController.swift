//
//  AnimeChanQuoteFavListViewController.swift
//  20230518TEST
//
//  Created by ShigeruEndo on 2023/05/18.
//

import SwiftUI

struct AnimeChanQuoteFavListViewController: View {
    @ObservedObject private var viewModel: AnimeChanQuoteFavListViewModel = AnimeChanQuoteFavListViewModel()

    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.favList) { animeChanQuote in
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text("title: ") + Text(animeChanQuote.anime)
                            Text("")
                            Text("character: ") + Text(animeChanQuote.character)
                            Text("")
                            Text("quote: ") + Text(animeChanQuote.quote)
                        }
                        .font(.system(size: 10, weight: .bold))
                        .frame(maxWidth: .infinity, minHeight: 100, alignment: .topLeading)
                        HStack {
                            Button(action: {
                                viewModel.deleteAnimeChanQuote(animeChanQuote: animeChanQuote)
                            }){
                                Text("お気に入り削除")
                                    .font(.system(size: 16, weight: .bold))
                            }
                        }
                    }
                }
            }
        }.onAppear {
            viewModel.fetchLoaclFavAnimeChanFavList()
        }
    }
}
