//
//  ArchivePlayerView.swift
//  CastSender
//
//  Created by Masato Arai on 07/10/2024.
//

import SwiftUI

struct ArchivePlayerView: View {
    @ObservedObject var viewModel: ViewModel

    @State private var isLoading = false

    var body: some View {
        VStack {
            if isLoading {
                ProgressView().scaleEffect(2)
            } else {
                Button(action: {
                    if viewModel.currentPlayingChannel == .archive {
                        viewModel.pauseArchiveStream()
                    } else {
                        viewModel.playArchiveStream()
                    }
                }) {
                    Image(systemName: viewModel.currentPlayingChannel == .archive ? "pause.fill" : "play.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.primary)
                }
            }
        }
    }
}
