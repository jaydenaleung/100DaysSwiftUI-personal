//
//  ContentView.swift
//  Friends
//
//  Created by Student on 12/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var users: [User]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(users) { user in
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
