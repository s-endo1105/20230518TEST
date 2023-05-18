//
//  APIClient.swift
//  20230518TEST
//
//  Created by ShigeruEndo on 2023/05/18.
//

import APIKit
import UIKit

class APIClient {
    static let shared = APIClient()
    private var isRetry: Bool

    init() {
        isRetry = false
    }

    func sendRequest<T: APIKit.Request>(
        _ request: T,
        handler: @escaping (Result<T.Response, Error>) -> Void
    ) -> SessionTask? {
        APISession.shared.send(request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.isRetry = false
                handler(.success(response))
            case let .failure(error):
                print("API Resoponse Error \(error)")
                handler(.failure(error))
            }
        }
    }
}

extension APIClient {

    private func printDebugRequestLog<T: APIRequest>(request: T) {
        print("\n") // debugログの見やすさのため
        print(String(format: "Request URL %@", arguments: [request.url.absoluteString]))
        print("HTTP Method : \(request.method)")
        print("Param : \(request.parameters ?? "なし")")
        if let bodyParams = request.bodyParameters {
            print("BodyParam : \(bodyParams))")
        }
    }
}
