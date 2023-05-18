//
//  AnimeChanQuoteTitleRequest.swift
//  20230518TEST
//
//  Created by ShigeruEndo on 2023/05/18.
//

import APIKit
import Foundation

struct AnimeChanQuoteTitleRequest: APIRequest {
    
    var baseURL: URL  {
        URL(string: "https://animechan.vercel.app/api/")!
    }

    typealias Response = [AnimeChanQuote]
    
    var path: String
    var method: HTTPMethod
    var parameters: Any?

    init(component: AnimeChanQuoteTitleRequest.Component) {
        method = .get
        path = component.requestPath
        parameters = component.params()
    }
}

extension AnimeChanQuoteTitleRequest {
    struct Component {
        let requestPath: String = "quotes/anime"
        var title: String
        var page: Int

        func params() -> Any {
            [
                "title": title,
                "page": page
            ] as [String : Any]
        }
    }
}
