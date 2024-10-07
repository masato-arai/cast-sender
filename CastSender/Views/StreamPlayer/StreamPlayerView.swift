//
//  StreamPlayerView.swift
//  CastSender
//
//  Created by Masato Arai on 15/09/2024.
//

import SwiftUI

struct StreamPlayerView: View {
    @ObservedObject var viewModel: ViewModel

    @State private var isLoading = false

    var body: some View {
        VStack {
            if isLoading {
                ProgressView().scaleEffect(2)
            } else {
                Button(action: {
                    if viewModel.currentPlayingChannel == .ch1 {
                        viewModel.pauseLiveStream()
                    } else {
                        viewModel.playLiveStream()
                    }
                }) {
                    Image(systemName: viewModel.currentPlayingChannel == .ch1 ? "pause.fill" : "play.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.primary)
                }
            }
        }
    }
}
