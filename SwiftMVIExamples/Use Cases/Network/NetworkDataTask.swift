//
//  DataTask.swift
//  SwiftMVIExamples
//
//  Created by Gabor Nagy on 2023. 01. 02..
//

import Foundation
import SwiftUseCase

extension Network {
    /// A **DataTask** is an assyncronous usecase that able to download data from internet or throwing an error.
    public struct DataTask: AsyncThrowingUseCase {
        public struct Parameter {
            let request: URLRequest
            let session: URLSession
        }
        public typealias Result = (response: HTTPURLResponse, data: Data)
        
        public var execute: AsyncThrowingExecutable<Parameter, Result> = { parameter in
            class CancellableWrapper {
                var dataTask: URLSessionDataTask?
            }
            let urlSessionTask = CancellableWrapper()
            return try await withTaskCancellationHandler {
                return try await withUnsafeThrowingContinuation { continuation in
                    urlSessionTask.dataTask = parameter.session.dataTask(with: parameter.request) { data, response, error in
                        if let error = error {
                            continuation.resume(throwing: error)
                        }
                        if let data = data {
                            let result = (response as! HTTPURLResponse, data)
                            continuation.resume(returning: result)
                        }
                    }
                    urlSessionTask.dataTask?.resume()
                }
            } onCancel: {
                urlSessionTask.dataTask?.cancel()
            }
        }
    }
}

extension Network.DataTask.Parameter {
    static func get(_ path: String, session: URLSession? = nil) -> Self {
        .init(
            request: URLRequest(url: URL(string: path)!),
            session: session ?? .shared
        )
    }
}
