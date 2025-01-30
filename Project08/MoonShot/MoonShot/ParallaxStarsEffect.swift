//
//  ParallaxStarsEffect.swift
//  MoonShot
//
//  Created by Tan Xin Jie on 30/1/25.
//

import SwiftUI

struct ParallaxStarsEffect: View {
    let starCount: Int
    @State private var stars: [Star] = []

    struct Star: Identifiable {
        let id = UUID()
        let x: CGFloat
        let y: CGFloat
        let size: CGFloat
        let speed: CGFloat
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(stars) { star in
                    Circle()
                        .fill(Color.white.opacity(0.8))
                        .frame(width: star.size, height: star.size)
                        .position(
                            x: star.x,
                            y: (geometry.frame(in: .global).minY * star.speed) + star.y
                        )
                }
            }
            .onAppear {
                generateStars(in: geometry.size)
            }
        }
        .ignoresSafeArea()
    }

    private func generateStars(in size: CGSize) {
        stars = (0..<starCount).map { _ in
            Star(
                x: CGFloat.random(in: 0...size.width),
                y: CGFloat.random(in: -500...size.height + 500),
                size: CGFloat.random(in: 1.5...4.0),
                speed: CGFloat.random(in: 0.1...0.5)
            )
        }
    }
}
