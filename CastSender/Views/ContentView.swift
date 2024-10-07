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
                VStack {
                    Spacer()
                    VStack(spacing: 96) {
                        VStack {
                            CastButtonView()
                        }
                        .frame(height: 48)

                        if let broadcast = data.first {
                            VStack(spacing: 24) {
                                Text("Ch\(broadcast.channel_name)")
                                    .font(.headline)
                                StreamPlayerView(viewModel: viewModel)
                            }
                        }
                        VStack(spacing: 24) {
                            Text("Archive Episode")
                                .font(.headline)
                            ArchivePlayerView(viewModel: viewModel)
                        }
                    }
                    Spacer()
                }
            } else {
                Text("Error fetching data")
            }
        }
    }
}
