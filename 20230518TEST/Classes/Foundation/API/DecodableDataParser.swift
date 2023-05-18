//
//  DecodableDataParser.swift
//  20230518TEST
//
//  Created by ShigeruEndo on 2023/05/18.
//

import APIKit
import SwiftUI
import Foundation

final class DecodableDataParser: DataParser {
    var contentType: String? {
        "application/json"
    }

    func parse(data: Data) throws -> Any {
        data
    }
}
