//
//  CafeRowView.swift
//  iChugChug
//
//  Created by Melissa Webster on 6/11/25.
//

import SwiftUI
import CoreLocation

struct CafeRowView: View {
    let cafe: Cafe
    
    @StateObject private var locationManager = LocationManager.shared

    var body: some View {
        HStack {
            AsyncImage(url: cafe.imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 60, height: 60)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipped()
                        .cornerRadius(8)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading) {
                HStack(spacing: 4) {
                    Text(cafe.name)
                        .font(.headline)
                    
                    if let distance = distanceText() {
                        Text("(\(distance))")
                            .font(.caption)
                            .foregroundColor(.detail)
                    }
                }
                Text("\(cafe.streetAddress) \(cafe.city), \(cafe.state) \(cafe.postalCode)")
                    .font(.body)
                    .foregroundColor(.detail)
                
                let tags = cafe.goodFor.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                
                HStack(spacing: 8) {
                    ForEach(tags, id: \.self) { tag in
                        Image(systemName: symbolForTag(tag))
                            .accessibilityLabel(Text(tag))
                            .foregroundColor(.accentColor)
                            .imageScale(.medium)
                    }
                }
            }
            .padding(.leading, 8)
        }
    }
    
    private func distanceText() -> String? {
        guard let userLocation = locationManager.userLocation else { return nil }
        let cafeLocation = CLLocation(latitude: cafe.latitude, longitude: cafe.longitude)
        let distanceInMiles = cafeLocation.distance(from: userLocation) / 1609.34
        return String(format: "%.1f mi", distanceInMiles)
    }
}

#Preview {
    CafeRowView(cafe: fakeCafesExample.first!)
}
