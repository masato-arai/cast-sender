//
//  ContentView.swift
//  CastSender
//
//  Created by Masato Arai on 13/09/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let data = viewModel.data {
                List(data) { broadcast in
                    VStack(alignment: .leading) {
                        Text("Ch\(broadcast.channel_name)")
                            .font(.headline)
                    }
                }
            } else {
                Text("Error fetching data")
            }
        }
    }
}

#Preview {
    ContentView()
}
