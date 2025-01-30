//
//  MoonShotApp.swift
//  MoonShot
//
//  Created by Tan Xin Jie on 29/1/25.
//

import SwiftUI

@main
struct MoonShotApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON.")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}


extension ShapeStyle where Self == Color {
    static var spaceBackground: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.05, green: 0.05, blue: 0.2),
                Color(red: 0.1, green: 0.05, blue: 0.3),
                Color.black
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
