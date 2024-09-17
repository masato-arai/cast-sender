//
//  StreamPlayer.swift
//  CastSender
//
//  Created by Masato Arai on 14/09/2024.
//

import SwiftUI
import AVFoundation

class StreamPlayer {
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
