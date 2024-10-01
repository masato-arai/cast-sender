//
//  ContentView.swift
//  CastSender
//
//  Created by Masato Arai on 13/09/2024.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject var viewModel = ViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let data = viewModel.data {
                HStack {

                    if let broadcast = data.first {
                        HStack(spacing: 20) {
                            Text("Ch\(broadcast.channel_name)")
                                .font(.headline)
                            StreamPlayerView(viewModel: viewModel)
                        }
                    }

                    CastButtonView()
                        .frame(width: 100)
                }
            } else {
                Text("Error fetching data")
            }
        }
    }
}

//#Preview {
//    ContentView()
//}
