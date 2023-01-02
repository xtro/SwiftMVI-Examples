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
            if feature.state.isLoading {
                ZStack(alignment: .center) {
                    Text("Loading...")
                }
            } else {
                ScrollView {
                    VStack {
                        if let assets = feature.state.assets {
                            if assets.isEmpty {
                                Text("Empty")
                            } else {
                                ForEach(assets, id: \.id) { asset in
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
            }
        }
        .onAppear {
            feature(.fetch)
        }
        .onReceive(feature.publisher) { event in
            switch event {
            case let .downloadFailure(error):
                print(error)
            }
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
