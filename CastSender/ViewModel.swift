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

class ViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var data: [Broadcast]?
    @Published var errorMessage: String?
    @Published var metadata = GCKMediaMetadata()
    @State var streamPlayer = StreamPlayer()

    let apiEndPoint = "https://www.nts.live/api/v2/live"
    let ch1StreamURL = "https://stream-relay-geo.ntslive.net/stream"
    let mockImageUrl = "https://media.ntslive.co.uk/resize/1600x1600/70f4bd2c-38d0-4a2a-b067-fe2182af4e3a_1727827200.jpeg"

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

    func play() {
        streamPlayer.play(urlString: ch1StreamURL)
    }

    func pause() {
        streamPlayer.pause()
    }

    func castLiveStream() {
        GCKCastContext.sharedInstance().presentDefaultExpandedMediaControls()

        metadata.setString("NTS Live Ch1", forKey: kGCKMetadataKeyTitle)
        metadata.setString(
            "NTS is a global radio platform broadcasting music from over 50 cities around the globe, live 24/7.",
            forKey: kGCKMetadataKeySubtitle
        )
        metadata.setString("Artist", forKey: kGCKMetadataKeyArtist)
        metadata.setString("Album Artist", forKey: kGCKMetadataKeyAlbumArtist)
        metadata.setString("Album Title", forKey: kGCKMetadataKeyAlbumTitle)
        metadata.setString("Composer", forKey: kGCKMetadataKeyComposer)
        metadata.setString("Series Title", forKey: kGCKMetadataKeySeriesTitle)
        metadata.setString("Studio", forKey: kGCKMetadataKeyStudio)
        metadata.setString("Location", forKey: kGCKMetadataKeyLocationName)
        metadata.addImage(
            GCKImage(
                url: URL(string: mockImageUrl)!,
                width: 480,
                height: 360
            )
        )

        // prepare mediaInfromation to cast
        let url = URL(string: ch1StreamURL)
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
        GCKCastContext.sharedInstance().sessionManager.currentSession?.remoteMediaClient?.loadMedia(mediaInfo)
    }
}
