//
//  FavDatastore.swift
//  20230518TEST
//
//  Created by ShigeruEndo on 2023/05/18.
//

import Foundation
import SQLite

class FavDatastore {
    private let table = Table("fav")
    private let id = Expression<Int64>("id")
    private let anime = Expression<String>("anime")
    private let character = Expression<String>("character")
    private let quote = Expression<String>("quote")
    private let db: Connection

    init(db: Connection) {
        self.db = db
        do {
            try self.db.run(table.create { t in
                t.column(Expression<Int64>("id"), primaryKey: true)
                t.column(Expression<String>("anime"))
                t.column(Expression<String>("character"))
                t.column(Expression<String>("quote"))
            })
        } catch {}
    }

    func findAll() -> [AnimeChanQuote] {
        var results = [AnimeChanQuote]()
        // エラー起こした場合は空の配列を返却
        guard let animeChanQuotes = try? db.prepare(table) else {
            return results
        }
        for row in animeChanQuotes {
            results.append(
                AnimeChanQuote(
                    id: Int(row[self.id]),
                    anime: row[self.anime],
                    character: row[self.character],
                    quote: row[self.quote]
                )
            )
        }
        return results
    }

    func findByAnimeAndCharacterAndQuote(anime: String, character: String, quote: String) -> AnimeChanQuote? {
        var results = [AnimeChanQuote]()
        // エラー起こした場合はnilを返却
        guard let animeChanQuotes = try? db.prepare(table.where(self.anime == anime).where(self.character == character).where(self.quote == quote)) else {
            return nil
        }
        for row in animeChanQuotes {
            results.append(
                AnimeChanQuote(
                    id: Int(row[self.id]),
                    anime: row[self.anime],
                    character: row[self.character],
                    quote: row[self.quote]
                )
            )
        }
        //TODO. 基本は1件想定だが複数あった時のために先頭だけ返す(APIのデータが1件とは限らない？使用不明確のため一旦エラーを避けるための処理)
        return results.first
    }

    func insert(anime: String, character: String, quote: String) throws {
        let insert = table.insert(self.anime <- anime, self.character <- character, self.quote <- quote)
        try db.run(insert)
    }

    func delete(targetId: Int64) throws {
        let row = table.filter(self.id == targetId)
        try db.run(row.delete())
    }

    func deleteByAnimeAndCharacterAndQuote(anime: String, character: String, quote: String) throws {
        let row = table.filter(self.anime == anime).filter(self.character == character).filter(self.quote == quote)
        try db.run(row.delete())
    }
}
