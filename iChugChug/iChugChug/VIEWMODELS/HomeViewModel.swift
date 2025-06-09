//
//  HomeViewModel.swift
//  iChugChug
//
//  Created by Melissa Webster on 6/6/25.
//

import Foundation
import CoreLocation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var cafes: [Cafe] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let locationManager = LocationManager()
    private let apiService = APIService.shared
    private let networkMonitor = NetworkMonitor.shared
    
    init() {
        Task {
            await loadCafes()
        }
    }

    func loadCafes() async {
        guard networkMonitor.isConnected else {
            errorMessage = "No internet connection."
            return
        }

        isLoading = true

        do {
            let allCafes = try await apiService.fetchCafes()
            
            if let userLocation = locationManager.userLocation {
                cafes = sortByDistance(from: userLocation, cafes: allCafes)
            } else {
                cafes = allCafes
            }

            errorMessage = nil
        } catch {
            errorMessage = "Failed to load cafes."
            cafes = []
        }

        isLoading = false
    }

    private func sortByDistance(from location: CLLocation, cafes: [Cafe]) -> [Cafe] {
        return cafes.sorted {
            let loc1 = CLLocation(latitude: $0.latitude, longitude: $0.longitude)
            let loc2 = CLLocation(latitude: $1.latitude, longitude: $1.longitude)
            return loc1.distance(from: location) < loc2.distance(from: location)
        }
    }
}
