//
//  ContentView.swift
//  MoonShot
//
//  Created by Tan Xin Jie on 29/1/25.
//

import SwiftUI

struct Astronaut: Codable, Identifiable{
    let id: String
    let name: String
    let description: String
}

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}

struct HomeView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 0.1, green: 0.1, blue: 0.2))
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(red: 0.1, green: 0.1, blue: 0.2))
                            )
                            .background(ParallaxStarsEffect(starCount: 25))
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    HomeView()
}
