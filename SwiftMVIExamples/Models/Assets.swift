//
//  DataTask.swift
//  SwiftMVIExamples
//
//  Created by Gabor Nagy on 2023. 01. 02..
//

import Foundation
import SwiftUseCase

public struct AssetItemData: Decodable {
    let id: String
    let rank: String
    let symbol: String
    let name: String
    let supply: String
    let maxSupply: String?
    let marketCapUsd: String?
    let volumeUsd24Hr: String?
    let priceUsd: String
    let changePercent24Hr: String?
    let vwap24Hr: String?
    let explorer: String?
}
public struct AssetsData: Decodable {
    let data: [AssetItemData]
}
