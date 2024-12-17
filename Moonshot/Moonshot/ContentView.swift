//
//  ContentView.swift
//  Moonshot
//
//  Created by Jayden Leung on 9/5/24.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    @State private var gridView: Bool = true
    var viewPadding: CGFloat {
        if gridView == true {
            85
        } else {
            -95
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack {
                    HStack {
                        Rectangle()
                            .fill(Color.primary)
                            .opacity(0.3)
                            .frame(width: 90, height: 30)
                            .cornerRadius(15)
                            .padding(.trailing, viewPadding)
                    }
                    
                    HStack {
                        Button("Grid View") { withAnimation { gridView = true } }
                            .padding(.trailing, 5)
                            .foregroundStyle(.primary)
                        Button("List View") { withAnimation { gridView = false } }
                            .padding(.leading, 5)
                            .foregroundStyle(.primary)
                    }
                }
                .padding(.bottom, 10)
                
                Group {
                    if gridView {
                        GridView()
                    } else {
                        ListView()
                    }
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
