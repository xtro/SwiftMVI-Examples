//
//  ContentView.swift
//  SwiftMVIExamples
//
//  Created by Gabor Nagy on 2023. 01. 02..
//

import SwiftUI
import SwiftMVI
import SwiftUseCase
import Foundation

struct ContentView: View {
    @StateObject private var feature = AssetsFeature()
    
    var body: some View {
        Group {
            switch feature.state {
            case .loading:
                ZStack(alignment: .center) {
                    Text("Loading...")
                }
            case .failed(let error):
                ZStack(alignment: .center) {
                    Text("\(error.localizedDescription)")
                }
            case .assets(let list):
                ScrollView {
                    VStack {
                        ForEach(list, id: \.id) { asset in
                            HStack {
                                Text(asset.name)
                                    .bold()
                                Spacer()
                                Text("\(currency: asset.priceUsd)")
                            }
                            .padding(.horizontal)
                            Rectangle().foregroundColor(.gray).frame(height: 1)
                        }
                    }
                }
            }
        }
        .onAppear {
            feature(.fetch)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private extension LocalizedStringKey.StringInterpolation {
    mutating func appendInterpolation(currency: String) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        if let result = formatter.string(from: Double(currency)! as NSNumber) {
            appendLiteral(result)
        }
    }
}
