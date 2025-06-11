//
//  Cafe.swift
//  iChugChug
//
//  Created by Melissa Webster on 6/6/25.
//

import Foundation
import CoreLocation

struct Cafe: Codable, Identifiable, Hashable {
    let id: UUID = UUID()
    let name: String
    let category: String
    let latitude: Double
    let longitude: Double
    let streetAddress: String
    let city: String
    let state: String
    let postalCode: String
    let phoneNumber: String
    let description: String
    let goodFor: String
    let openTime: String
    let closeTime: String
    let imageName: String
    
    var imageURL: URL? {
        URL(string: "https://github.com/MDWdev/iChugChug/blob/main/OnlineAssets/\(imageName)?raw=true")
    }
}

struct CafeResponse: Codable {
    let cafes: [Cafe]
}

let fakeCafesExample = [
    Cafe(name: "Great Lakes Coffee",
         category: "Coffee Shop",
         latitude: 42.321992,
         longitude: -83.060322,
         streetAddress: "3965 Woodward Ave",
         city: "Detroit",
         state: "MI",
         postalCode: "48201",
         phoneNumber: "(313) 555-1000",
         description: "Modern cafe with locally roasted coffee and comfy seating.",
         goodFor: "Remote Work",
         openTime: "7:00 AM",
         closeTime: "9:00 PM",
         imageName: "coffee1.jpg"
        ),
    Cafe(name: "Roasting Plant Coffee",
         category: "Espresso Bar",
         latitude: 42.355161,
         longitude: -83.019697,
         streetAddress: "660 Woodward Ave",
         city: "Detroit",
         state: "MI",
         postalCode: "48226",
         phoneNumber: "(313) 555-1002",
         description: "High-tech coffee bar with custom brews made to order.",
         goodFor: "Espresso, Pastries",
         openTime: "6:30 AM",
         closeTime: "8:00 PM",
         imageName: "coffee2.jpg"
        )
]
