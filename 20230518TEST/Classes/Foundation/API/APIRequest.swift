//
//  APIRequest.swift
//  20230518TEST
//
//  Created by ShigeruEndo on 2023/05/18.
//

import APIKit
import Foundation

protocol APIRequest: Request {}

extension APIRequest {

    var url: URL {
        URL(string: "https://animechan.vercel.app/api/quotes")!
    }

    var urlString: String {
        url.absoluteString
    }

    var headerFields: [String: String] {
        [:]
    }
}

extension APIRequest where Response: Decodable {
    var dataParser: DataParser {
        DecodableDataParser()
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }

        if data.count == 0, let emptyData = EmptyResponse.emptyJson.data(using: .utf8) {
            return try JSONDecoder().decode(Response.self, from: emptyData)
        }

        return try JSONDecoder().decode(Response.self, from: data)
    }
}

extension APIRequest {
    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        let code = urlResponse.statusCode

        if (200 ..< 300).contains(code) {
            return object
        }
        throw NSError(domain: "error", code: -1, userInfo: nil)
    }
}
