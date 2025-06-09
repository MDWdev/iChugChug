//
//  CafesListView.swift
//  iChugChug
//
//  Created by Melissa Webster on 6/9/25.
//

import SwiftUI

struct CafesListView: View {
    let cafes: [Cafe]
    @Binding var path: NavigationPath
    
    var body: some View {
        List(cafes) { cafe in
            Button {
                path.append(cafe)
            } label: {
                VStack(alignment: .leading, spacing: 4) {
                    Text(cafe.name)
                        .font(.headline)
                    Text(cafe.streetAddress)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

#Preview {
    StatefulPreviewWrapper(NavigationPath()) { path in
        CafesListView(cafes: fakeCafesExample, path: path)
    }
}
