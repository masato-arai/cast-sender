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

    let title = "Sui Zhen - Lebanon Special"
    let description = "Hour long explorations with Melbourne experimental pop producer & artist Sui Zhen."
    let imageUrl = "https://media2.ntslive.co.uk/crop/750x750/25c55baf-af33-4c74-9480-1794fb003a33_1728259200.png"

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
                        viewModel.castPlay(
                            title: title,
                            description: description,
                            imageUrl: imageUrl,
                            audioUrl: viewModel.ch1StreamURL
                        )
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
