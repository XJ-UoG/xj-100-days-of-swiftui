//
//  MissionView.swift
//  MoonShot
//
//  Created by Tan Xin Jie on 30/1/25.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let crew: [CrewMember]
    let mission: Mission
    
    @State private var rotation = 0.0
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                    .padding(.top)
                    .rotation3DEffect(
                        .degrees(rotation),
                        axis: (x: 0, y: 1, z: 0)
                    )
                    .onTapGesture {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                            rotation += 360
                        }
                    }
                
                VStack(alignment: .leading) {
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(crew, id: \.role) { crewMember in
                                NavigationLink {
                                    AstronautView(astronaut: crewMember.astronaut)
                                } label: {
                                    HStack {
                                        Image(crewMember.astronaut.id)
                                            .resizable()
                                            .frame(width: 104, height: 72)
                                            .clipShape(.capsule)
                                            .overlay(
                                                Capsule()
                                                    .strokeBorder(.white, lineWidth: 1)
                                            )
                                        
                                        VStack(alignment: .leading) {
                                            Text(crewMember.astronaut.name)
                                                .foregroundStyle(.white)
                                                .font(.headline)
                                            Text(crewMember.role)
                                                .foregroundStyle(.white.opacity(0.5))
                                        }
                                    }
                                    .padding([.horizontal])
                                }
                            }
                        }
                    }
                    Rectangle()
                        .frame(height: 2)
                        .padding(.vertical)
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    Text(mission.description)
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.spaceBackground)
    }
}

struct AstronautView: View {
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
            }
        }
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
        .background(.spaceBackground)
    }
}
