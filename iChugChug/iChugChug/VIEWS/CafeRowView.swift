//
//  CafeRowView.swift
//  iChugChug
//
//  Created by Melissa Webster on 6/11/25.
//

import SwiftUI

struct CafeRowView: View {
    let cafe: Cafe

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
                Text(cafe.name)
                    .font(.headline)
                Text("\(cafe.streetAddress) \(cafe.city), \(cafe.state) \(cafe.postalCode)")
                    .font(.body)
                    .foregroundColor(.detail)
                
                let tags = cafe.goodFor.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                
                HStack(spacing: 8) {
                    ForEach(tags, id: \.self) { tag in
                        Image(systemName: symbolForTag(tag))
                            .foregroundColor(.accentColor)
                            .imageScale(.medium)
                    }
                }
            }
            .padding(.leading, 8)
        }
    }
}

#Preview {
    CafeRowView(cafe: fakeCafesExample.first!)
}
