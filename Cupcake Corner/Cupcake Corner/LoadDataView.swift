//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Student on 11/4/24.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackID: Int
    var trackName: String
    var collectionName: String
}

struct LoadDataView: View {
    @State private var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackID) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                
                Text(item.collectionName)
            }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song")
        else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    LoadDataView()
}
