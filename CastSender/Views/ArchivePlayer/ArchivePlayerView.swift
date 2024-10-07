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

    let title = "United In Flames w/ Evian Christ & Malibu "
    let description = "Malibu is a French electronic musician whose work sails between ambient and ethereal music." +
    "Forever inspired by soft reverbed vocals and melodious chord progressions, Malibu’s music is an immersive nostalgic journey in a sea of synthetic strings and choirs."
    let imageUrl = "https://media2.ntslive.co.uk/crop/750x750/c62b19d6-ae72-4a87-bb12-0250e54d5e90_1727827200.jpeg"

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
                        viewModel.castPlay(
                            title: title,
                            description: description,
                            imageUrl: imageUrl,
                            audioUrl: viewModel.sampleAudioURL
                        )
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
