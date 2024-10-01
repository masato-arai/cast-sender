//
//  StreamPlayerView.swift
//  CastSender
//
//  Created by Masato Arai on 15/09/2024.
//

import SwiftUI

struct StreamPlayerView: View {
    let viewModel: ViewModel

    @State private var isPlaying = false
    @State private var isLoading = false

    var body: some View {
        VStack {
            if isLoading {
                ProgressView().scaleEffect(2)
            } else {
                Button(action: {
                    if isPlaying {
                        viewModel.pause()
                    } else {
                        viewModel.play()
                        viewModel.castLiveStream()
                    }
                    isPlaying.toggle()
                }) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.primary)
                }
            }
        }
    }
}

//#Preview {
//    StreamPlayerView()
//}
