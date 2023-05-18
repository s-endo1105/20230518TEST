//
//  ContentView.swift
//  20230518TEST
//
//  Created by ShigeruEndo on 2023/05/18.
//

import SwiftUI

struct ContentView: View {
    @State var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            AnimeChanQuoteListViewController()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("名言リスト")
                }
                .tag(1)

            AnimeChanQuoteFavListViewController()
                .tabItem {
                    Image(systemName: "star")
                    Text("お気に入り一覧")
                }
                .tag(2)
        }
    }
}
