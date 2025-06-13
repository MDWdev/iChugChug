//
//  HomeViewModel.swift
//  iChugChug
//
//  Created by Melissa Webster on 6/6/25.
//

import Foundation
import CoreLocation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var cafes: [Cafe] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let locationManager = LocationManager.shared
    private let apiService = APIService.shared
    private let networkMonitor = NetworkMonitor.shared
    private var hasSortedByLocation = false
    
    init() {
        Task {
            await loadCafes()
            
            locationManager.$userLocation
                .compactMap { $0 }
                .first()
                .sink { [weak self] location in
                    Task { await self?.sortByLocation(location) }
                }
                .store(in: &cancellables)
        }
    }

    func loadCafes() async {
        guard NetworkMonitor.shared.isConnected else {
            errorMessage = "No internet connection."
            return
        }

        isLoading = true

        do {
            let allCafes = try await apiService.fetchCafes()
            self.cafes = allCafes
            errorMessage = nil
        } catch {
            errorMessage = "Failed to load cafes."
            cafes = []
        }

        isLoading = false
    }

    func sortByLocation(_ location: CLLocation) async {
        guard !hasSortedByLocation else { return }
        self.cafes = cafes.sorted {
            let loc1 = CLLocation(latitude: $0.latitude, longitude: $0.longitude)
            let loc2 = CLLocation(latitude: $1.latitude, longitude: $1.longitude)
            return loc1.distance(from: location) < loc2.distance(from: location)
        }
        hasSortedByLocation = true
    }

    private var cancellables = Set<AnyCancellable>()
}
