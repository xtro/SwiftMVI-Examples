//
//  Feature.swift
//  SwiftMVIExamples
//
//  Created by Gabor Nagy on 2023. 01. 02..
//

import Foundation
import SwiftMVI

typealias AsyncFeature = Observer & Processing & ReducibleState & AsyncIntentReducer & EventReducer

class AssetsFeature: AsyncFeature {
    class State {
        var assets: [AssetItemData]?
        var isLoading: Bool = false
    }
    var state = State()
    
    enum Event {
        case downloadFailure(any Error)
    }
    var publisher = Publisher()
    
    enum Intent {
        case fetch
    }
    
    func reduce(intent: Intent) async {
        do {
            await state {
                $0.isLoading = true
            }
            let result = try await run(Network.Assets())
            await state {
                $0.assets = result.data
                $0.isLoading = false
            }
        }catch{
            publish( .downloadFailure(error) )
        }
    }
}
