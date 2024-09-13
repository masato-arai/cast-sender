//
//  BroadcastModel.swift
//  CastSender
//
//  Created by Masato Arai on 13/09/2024.
//

import Foundation

struct Broadcast: Identifiable, Codable {
    let id: UUID = UUID()
    let channel_name: String
}

struct LiveData: Decodable {
    let results: [Broadcast]
}
