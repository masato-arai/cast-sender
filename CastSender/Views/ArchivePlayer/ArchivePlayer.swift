//
//  ArchivePlayer.swift
//  CastSender
//
//  Created by Masato Arai on 07/10/2024.
//

import SwiftUI
import AVFoundation

class ArchivePlayer {
    var player: AVPlayer?

    func play(urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        player = AVPlayer(url: url)
        player?.play()
    }

    func pause() {
        player?.pause()
    }
}
