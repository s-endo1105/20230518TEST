//
//  APISession.swift
//  20230518TEST
//
//  Created by ShigeruEndo on 2023/05/18.
//
import Foundation
import APIKit

class APISession {
    static let shared = APISession()

    private let session: Session

    private init() {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.requestCachePolicy = .useProtocolCachePolicy
        sessionConfig.urlCache = URLCache.shared
        let sessionAdapter = URLSessionAdapter(configuration: sessionConfig)
        session = Session(adapter: sessionAdapter)
    }

    func send<Request: APIKit.Request>(
        _ request: Request,
        handler: @escaping (Result<Request.Response, SessionTaskError>) -> Void = { _ in }
    ) -> SessionTask? {
        session.send(request, handler: handler)
    }
}

