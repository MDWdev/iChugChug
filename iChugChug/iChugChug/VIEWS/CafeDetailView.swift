//
//  CafeDetailView.swift
//  iChugChug
//
//  Created by Melissa Webster on 6/9/25.
//

import SwiftUI
import MapKit

struct CafeDetailView: View {
    let cafe: Cafe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Large Image
                AsyncImage(url: cafe.imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .clipped()
                            .cornerRadius(12)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                .padding(.horizontal)

                // Name + Tags
                VStack(alignment: .leading, spacing: 8) {
                    Text(cafe.name)
                        .font(.title)
                        .bold()

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
                .padding(.horizontal)

                // Address block
                VStack(alignment: .leading, spacing: 2) {
                    Button {
                        openInMaps()
                    } label: {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(cafe.streetAddress)
                            Text("\(cafe.city), \(cafe.state) \(cafe.postalCode)")
                        }
                        .font(.subheadline)
                        .foregroundColor(.detail)
                    }
                    .buttonStyle(.plain)

                    // Added spacing here
                    Spacer().frame(height: 12)

                    // Phone
                    Button {
                        if let url = URL(string: "tel://\(cafe.phoneNumber.onlyDigits())"),
                           UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Text(cafe.phoneNumber)
                            .font(.subheadline)
                            .foregroundColor(.detail)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding(.vertical)
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func openInMaps() {
        let address = "\(cafe.streetAddress), \(cafe.city), \(cafe.state) \(cafe.postalCode)"
        let encoded = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: "http://maps.apple.com/?address=\(encoded)") {
            UIApplication.shared.open(url)
        }
    }
}


#Preview {
    CafeDetailView(cafe: fakeCafesExample.first!)
}

