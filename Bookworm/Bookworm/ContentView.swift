//
//  ContentView.swift
//  Bookworm
//
//  Created by Student on 11/12/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.date),
        SortDescriptor(\Book.author)
                 ]) var books: [Book]
    
    @State private var addShowing = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)

                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                Text(book.date.formatted(date: .abbreviated, time: .omitted))
                                    .font(.subheadline)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Bookworm")
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        addShowing.toggle()
                    }
                }
                
//                ToolbarItem {
//                    Picker
//                } for sorting
            }
            .sheet(isPresented: $addShowing) { AddBookView() }
        }
    }
}

#Preview {
    ContentView()
}
