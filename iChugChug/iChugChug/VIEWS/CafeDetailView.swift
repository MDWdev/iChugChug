//
//  CafeDetailView.swift
//  iChugChug
//
//  Created by Melissa Webster on 6/9/25.
//

import SwiftUI

struct CafeDetailView: View {
    let cafe: Cafe

        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                Text(cafe.name)
                    .font(.title)
                    .bold()
                Text(cafe.streetAddress)
                    .font(.subheadline)
                Text("\(cafe.city), \(cafe.state) \(cafe.postalCode)")
                    .font(.subheadline)
                Text("Phone: \(cafe.phoneNumber)")
                    .font(.subheadline)

                Spacer()
            }
            .padding()
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
        }
}

#Preview {
    CafeDetailView(cafe: fakeCafesExample.first!)
}
