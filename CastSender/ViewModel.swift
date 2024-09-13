//
//  ViewModel.swift
//  CastSender
//
//  Created by Masato Arai on 13/09/2024.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var data: [Broadcast]?
    @Published var errorMessage: String?

    init() {
        fetchData()
    }

    func fetchData() {
        isLoading = true
        errorMessage = nil

        guard let url = URL(string: "https://www.nts.live/api/v2/live") else {
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
}
