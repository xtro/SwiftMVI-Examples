# SwiftMVI-Examples
Example application based on SwiftMVI & SwiftUseCase

```swift
import Foundation
import SwiftMVI
import SwiftUI

typealias AsyncFeature = Observer & Processing & ImmutableState & AsyncIntentReducer

class AssetsFeature: AsyncFeature {
    enum State {
        case loading
        case assets([AssetItemData])
        case failed(Error)
    }
    var state = .loading
    
    enum Intent {
        case fetch
    }
    
    func reduce(intent: Intent) async {
        do {
            await state { state in
                .loading
            }
            let assets = try await run(Network.getAssets).data
            await state { _ in
                .assets(assets)
            }
        }catch{
            await state { _ in
                .failed(error)
            }
        }
    }
}
```
