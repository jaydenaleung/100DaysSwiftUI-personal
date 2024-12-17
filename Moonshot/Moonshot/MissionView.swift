//
//  MissionView.swift
//  Moonshot
//
//  Created by Jayden Leung on 10/20/24.
//

import SwiftUI

let missionIndex = 3 // just for here! the input changes in contentview based on the icon clicked.

struct MissionView: View {
    let mission: Mission
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.5
                    }
                
                Text(mission.formattedLaunchDate)
                    .padding(5)
                
                VStack(alignment: .leading) {
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                }
                .padding(.horizontal)
                
                let missions: [Mission] = Bundle.main.decode("missions.json")
                let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
                ScrollingCrewView(mission: missions[missionIndex], astronauts: astronauts)
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission) {
        self.mission = mission
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    MissionView(mission: missions[missionIndex])
        .preferredColorScheme(.dark)
}
