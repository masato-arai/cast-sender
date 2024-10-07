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
                        if let broadcast = data.first {
                            HStack(spacing: 24) {
                                Text("LIVE NOW \(broadcast.channel_name)")
                                    .font(.headline)
                                StreamPlayerView(viewModel: viewModel)
                                CastButtonView()
                                    .frame(width: 24, height: 24)
                            }
                        }
                        HStack(spacing: 24) {
                            Text("ARCHIVE")
                                .font(.headline)
                            ArchivePlayerView(viewModel: viewModel)
                            CastButtonView()
                                .frame(width: 24, height: 24)
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
