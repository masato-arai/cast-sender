//
//  ViewModel.swift
//  CastSender
//
//  Created by Masato Arai on 13/09/2024.
//

import Foundation
import Combine
import GoogleCast
import SwiftUI

enum ChannelType: String, CaseIterable {
    case ch1
    case archive
    case none
}

class ViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var data: [Broadcast]?
    @Published var errorMessage: String?
    @Published var metadata = GCKMediaMetadata()
    @State var streamPlayer = StreamPlayer()
    @State var archivePlayer = ArchivePlayer()
    @Published var currentPlayingChannel: ChannelType = .none

    let apiEndPoint = "https://www.nts.live/api/v2/live"
    let ch1StreamURL = "https://stream-relay-geo.ntslive.net/stream"
    let mockImageUrl = "https://media.ntslive.co.uk/resize/1600x1600/70f4bd2c-38d0-4a2a-b067-fe2182af4e3a_1727827200.jpeg"
    let sampleAudioURL = "https://onlinetestcase.com/wp-content/uploads/2023/06/1-MB-MP3.mp3"

    init() {
        fetchData()
    }

    func fetchData() {
        isLoading = true
        errorMessage = nil

        guard let url = URL(string: apiEndPoint) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, error == nil, let data = data else {
                print("Error fetching data: \(error?.localizedDescription ?? "")")
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(LiveData.self, from: data)
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.data = decodedData.results
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }

    func playLiveStream() {
        if (currentPlayingChannel == .archive) {
            archivePlayer.pause()
        }

        streamPlayer.play(urlString: ch1StreamURL)
        updateCurrentPlayingChannel(newChannelType: .ch1)
    }

    func pauseLiveStream() {
        streamPlayer.pause()
        updateCurrentPlayingChannel(newChannelType: .none)
    }

    func playArchiveStream() {
        if (currentPlayingChannel == .ch1) {
            streamPlayer.pause()
        }

        archivePlayer.play(urlString: sampleAudioURL)
        updateCurrentPlayingChannel(newChannelType: .archive)
    }

    func pauseArchiveStream() {
        archivePlayer.pause()
        updateCurrentPlayingChannel(newChannelType: .none)
    }

    func castLiveStream() {
        GCKCastContext.sharedInstance().presentDefaultExpandedMediaControls()

        metadata.setString("NTS Live Ch1", forKey: kGCKMetadataKeyTitle)
        metadata.setString(
            "NTS is a global radio platform broadcasting music from over 50 cities around the globe, live 24/7.",
            forKey: kGCKMetadataKeySubtitle
        )
        metadata.addImage(
            GCKImage(
                url: URL(string: mockImageUrl)!,
                width: 480,
                height: 360
            )
        )

        // prepare mediaInfromation to cast
        let url = URL(string: sampleAudioURL)
        guard let mediaURL = url else {
            print("invalid mediaURL")
            return
        }

        let mediaInfoBuilder = GCKMediaInformationBuilder(contentURL: mediaURL)
        mediaInfoBuilder.streamType = GCKMediaStreamType.live;
        mediaInfoBuilder.contentType = "audio/mpeg"
        mediaInfoBuilder.metadata = metadata;
        var mediaInformation: GCKMediaInformation?
        mediaInformation = mediaInfoBuilder.build()

        let mediaLoadRequestDataBuilder = GCKMediaLoadRequestDataBuilder()
        mediaLoadRequestDataBuilder.mediaInformation = mediaInformation
        mediaLoadRequestDataBuilder.autoplay = true

        guard let mediaInfo = mediaInformation else {
            print("invalid mediaInformation")
            return
        }

        // Load your media
        let sessionManager = GCKCastContext.sharedInstance().sessionManager
        sessionManager.currentSession?.remoteMediaClient?.loadMedia(mediaInfo)
    }

    func updateCurrentPlayingChannel(newChannelType: ChannelType) {
        currentPlayingChannel = newChannelType
    }
}
