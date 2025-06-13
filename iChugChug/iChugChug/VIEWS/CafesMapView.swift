//
//  CafesMapView.swift
//  iChugChug
//
//  Created by Melissa Webster on 6/9/25.
//

import SwiftUI
import MapKit

struct CafesMapView: View {
    let cafes: [Cafe]
    @State private var selectedCafe: Cafe?
    @State private var region: MKCoordinateRegion
    @StateObject private var locationManager = LocationManager.shared
    @Binding var path: NavigationPath

    init(cafes: [Cafe], path: Binding<NavigationPath>) {
        self.cafes = cafes
        self._path = path

        if let first = cafes.first {
            _region = State(initialValue: MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: first.latitude, longitude: first.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
        } else {
            _region = State(initialValue: MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 42.3314, longitude: -83.0458),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
        }
    }

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: cafes) { cafe in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: cafe.latitude, longitude: cafe.longitude)) {
                VStack(spacing: 4) {
                    // Custom callout when selected
                    if selectedCafe == cafe {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(cafe.name)
                                .font(.caption)
                                .bold()

                            if let userLoc = locationManager.userLocation {
                                let cafeLoc = CLLocation(latitude: cafe.latitude, longitude: cafe.longitude)
                                let distance = cafeLoc.distance(from: userLoc) / 1609.34 // meters → miles
                                Text(String(format: "%.1f miles away", distance))
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }

                            Button {
                                path.append(cafe)
                                selectedCafe = nil
                            } label: {
                                HStack(spacing: 4) {
                                    Text("Details")
                                        .font(.caption2)
                                    Image(systemName: "chevron.right")
                                        .font(.caption2)
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.accentColor)
                        }
                        .padding(8)
                        .background(.thinMaterial)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                    }

                    // Always-visible pin
                    Button {
                        selectedCafe = cafe
                    } label: {
                        VStack(spacing: 0) {
                            Image(systemName: "cup.and.saucer.fill")
                                .foregroundColor(.white)
                                .padding(8)
                                .background(Circle().fill(Color.accentColor))
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))

                            Triangle()
                                .fill(Color.accentColor)
                                .frame(width: 12, height: 6)
                                .rotationEffect(.degrees(180))
                        }
                    }
                    .buttonStyle(.plain)
                }
            }

        }
        .navigationTitle("Cafe Map")
        .edgesIgnoringSafeArea(.all)
    }
}


#Preview {
    StatefulPreviewWrapper(NavigationPath()) { path in
        CafesMapView(cafes: fakeCafesExample, path: path)
    }
}
