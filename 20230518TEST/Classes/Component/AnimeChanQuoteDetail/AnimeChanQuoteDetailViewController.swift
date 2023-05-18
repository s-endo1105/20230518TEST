//
//  AnimeChanQuoteDetailViewController.swift
//  20230518TEST
//
//  Created by ShigeruEndo on 2023/05/18.
//

import SwiftUI

struct AnimeChanQuoteDetailViewController: View {
    @ObservedObject private var viewModel: AnimeChanQuoteDetailViewModel = AnimeChanQuoteDetailViewModel()
    @State var buttonText = ""

    let animeChanQuote: AnimeChanQuote

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("title: ") + Text(animeChanQuote.anime)
                Text("")
                Text("character: ") + Text(animeChanQuote.character)
                Text("")
                Text("quote: ") + Text(animeChanQuote.quote)
            }
            .padding(32)
            .font(.system(size: 16, weight: .bold))
            .frame(maxWidth: .infinity, minHeight: 100, alignment: .topLeading)
            HStack {
                Spacer()
                Button(action: {
                    viewModel.updateFavorite(animeChanQuote: animeChanQuote)
                }){
                    Text(viewModel.buttonText)
                        .font(.system(size: 20, weight: .bold))
                }
                Spacer()
            }
            Spacer()
        }.onAppear() {
            viewModel.fetchLocalFavorite(animeChanQuote: animeChanQuote)
        }
    }
}

