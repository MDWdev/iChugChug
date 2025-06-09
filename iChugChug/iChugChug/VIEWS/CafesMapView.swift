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
                Button(action: {
                    DispatchQueue.main.async {
                        path.append(cafe)
                    }
                }) {
                    Image(systemName: "mappin.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.accentColor)
                }
                .buttonStyle(.plain)
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
