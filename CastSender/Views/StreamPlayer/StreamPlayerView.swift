//
//  StreamPlayerView.swift
//  CastSender
//
//  Created by Masato Arai on 15/09/2024.
//

import SwiftUI

struct StreamPlayerView: View {
    @State private var streamPlayer = StreamPlayer()
    @State private var isPlaying = false
    @State private var isLoading = false
    let ch1StreamURL = "https://stream-relay-geo.ntslive.net/stream"

    var body: some View {
        VStack {
            if isLoading {
                ProgressView().scaleEffect(2)
            } else {
                Button(action: {
                    if isPlaying {
                        streamPlayer.pause()
                    } else {
                        streamPlayer.play(urlString: ch1StreamURL)
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

#Preview {
    StreamPlayerView()
}
