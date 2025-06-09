//
//  APIService.swift
//  iChugChug
//
//  Created by Melissa Webster on 6/6/25.
//

import Foundation


// https://run.mocky.io/v3/a1be7acb-c6f4-466e-9ca9-cd6d5f668bae?mocky-delay=500ms


class APIService {
    static let shared = APIService()

    func fetchCafes() async throws -> [Cafe] {
        guard let url = Bundle.main.url(forResource: "cafes", withExtension: "json") else {
            throw NSError(domain: "Missing cafes.json", code: 404)
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(CafeResponse.self, from: data)
            return decoded.cafes
        } catch {
            print("💥 Decoding failed with error: \(error)")
            if let dataString = String(data: try! Data(contentsOf: url), encoding: .utf8) {
                print("📄 Raw JSON:\n\(dataString)")
            }
            throw error
        }
    }
}
