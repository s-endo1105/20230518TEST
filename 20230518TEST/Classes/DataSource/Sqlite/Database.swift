//
//  Database.swift
//  20230518TEST
//
//  Created by ShigeruEndo on 2023/05/18.
//

import Foundation
import SQLite

let FILE_NAME = "animechan.db"

class Database {
    var db: Connection
    let favDatastore: FavDatastore

    init() {
      let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(FILE_NAME).path
      db = try! Connection(filePath)
        // FavDatastoreを初期化
        favDatastore = FavDatastore(db: db)
    }
}
