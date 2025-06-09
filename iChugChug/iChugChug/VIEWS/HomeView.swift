//
//  HomeView.swift
//  iChugChug
//
//  Created by Melissa Webster on 6/9/25.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var path = NavigationPath()
    @State private var showMap = false
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Loading Cafes...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    if showMap {
                        CafesMapView(cafes: viewModel.cafes, path: $path)
                    } else {
                        CafesListView(cafes: viewModel.cafes, path: $path)
                    }
                }
            }
            .navigationTitle("Nearby Cafes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showMap.toggle() }) {
                        Image(systemName: showMap ? "list.bullet" : "map")
                            .imageScale(.large)
                    }
                }
            }
            .navigationDestination(for: Cafe.self) { cafe in
                CafeDetailView(cafe: cafe)
            }
        }
    }
}

#Preview {
    HomeView()
}
