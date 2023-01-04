//
//  DataTask.swift
//  SwiftMVIExamples
//
//  Created by Gabor Nagy on 2023. 01. 02..
//

import Foundation
import SwiftUseCase

extension Network {
    public struct GetAssets: AsyncThrowingUseCase {
        public typealias Parameter = Void
        public typealias Result = AssetsData
        
        public var execute: AsyncThrowingExecutable<Parameter, Result> = { _ in
            let task = try await Network.dataTask(.get("https://api.coincap.io/v2/assets"))
            return try JSONDecoder().decode(AssetsData.self, from: task.data)
        }
    }
}
