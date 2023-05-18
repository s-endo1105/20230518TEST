//
//  _0230518TESTApp.swift
//  20230518TEST
//
//  Created by ShigeruEndo on 2023/05/18.
//

import SwiftUI

@main
struct _0230518TESTApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
