//
//  CastButtonView.swift
//  CastSender
//
//  Created by Masato Arai on 23/09/2024.
//

import SwiftUI
import GoogleCast

struct CastButtonView: UIViewRepresentable {
    private let delegate = CastButtonDelegate()

    func makeUIView(context: Context) -> GCKUICastButton {
        let castButton = GCKUICastButton()
        castButton.addTarget(delegate, action: #selector(CastButtonDelegate.didTapCastButton), for: .touchUpInside)
        return castButton
    }

    func updateUIView(_ uiView: GCKUICastButton, context: Context) {
        // Update any properties of the cast button as needed
    }
}

class CastButtonDelegate: NSObject {
    @objc func didTapCastButton() {
        // Handle the cast button tap event here
        print("Cast button tapped!")
    }
}
