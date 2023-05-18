//
//  AnimeChanQuoteRequest.swift
//  20230518TEST
//
//  Created by ShigeruEndo on 2023/05/18.
//

import APIKit
import Foundation

struct AnimeChanQuoteRequest: APIRequest {
    
    var baseURL: URL  {
        URL(string: "https://animechan.vercel.app/api/")!
    }

    typealias Response = [AnimeChanQuote]
    
    var path: String
    var method: HTTPMethod
    var parameters: Any?

    init(component: AnimeChanQuoteRequest.Component) {
        method = .get
        path = component.requestPath
        parameters = component.params()
    }
}

extension AnimeChanQuoteRequest {
    struct Component {
        let requestPath: String = "quotes"
        var page: Int

        func params() -> Any {
            [
                "page": page
            ]
        }
    }
}
