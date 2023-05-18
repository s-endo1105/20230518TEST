//
//  AnimeChanQuoteListViewController.swift
//  20230518TEST
//
//  Created by ShigeruEndo on 2023/05/18.
//

import SwiftUI

struct AnimeChanQuoteListViewController: View {
    @ObservedObject private var viewModel: AnimeChanQuoteListViewModel = AnimeChanQuoteListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    TextField("検索するアニメタイトルを入力してください。", text: $viewModel.searchTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.system(size: 12, weight: .regular))
                        .frame(maxWidth: .infinity, minHeight: 50, alignment: .topTrailing)
                    Spacer()
                    Button(action: {
                        viewModel.tappedSearchBtn()
                    }){
                        Text("検索")
                            .font(.system(size: 12, weight: .bold))
                    }
                    .frame(width: 50, height: 50, alignment: .center)
                    Button(action: {
                        viewModel.tappedClearSearchTitleBtn()
                    }){
                        Text("クリア")
                            .font(.system(size: 12, weight: .bold))
                    }
                    .frame(width: 50, height: 50, alignment: .center)
                    Spacer()
                }
                .frame(maxWidth: .infinity, minHeight: 50, alignment: .topLeading)
                List {
                    ForEach(viewModel.quoteList) { animeChanQuote in
                        NavigationLink(destination: AnimeChanQuoteDetailViewController(animeChanQuote: animeChanQuote) ) {
                            VStack(alignment: .leading) {
                                Text("title: ") + Text(animeChanQuote.anime)
                                Text("")
                                Text("character: ") + Text(animeChanQuote.character)
                                Text("")
                                Text("quote: ") + Text(animeChanQuote.quote)
                            }
                            .onAppear() {
                                if viewModel.checkDesplayScrollBottomCell(displayQuote: animeChanQuote) {
                                    if viewModel.searchTitle.isEmpty {
                                        viewModel.fetchAnimeChanQuote(isLoadMore: true)
                                    } else {
                                        viewModel.fetchAnimeChanQuoteTitle(isLoadMore: true)
                                    }
                                }
                            }
                            .font(.system(size: 10, weight: .bold))
                            .frame(maxWidth: .infinity, minHeight: 100, alignment: .topLeading)
                            .onTapGesture {
                                viewModel.detailScreenTransition(animeChanQuote: animeChanQuote)
                            }
                        }
                    }
                }
                Spacer()
            }
            if viewModel.isLoading {
                ProgressView()
            }
        }
    }
}

