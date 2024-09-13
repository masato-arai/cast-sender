//
//  BroadcastModel.swift
//  CastSender
//
//  Created by Masato Arai on 13/09/2024.
//

import Foundation

struct Broadcast: Codable {
    let channel_name: String
}

struct LiveData: Codable {
    let results: [Broadcast]
}
