//
//  ContentView.swift
//  Bookworm
//
//  Created by Pau Valverde Molina on 10/21/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    //Access the model context from where the data is beign read from
    @Environment(\.modelContext) var modelContext
    
    // @Query will make SwiftData load books from the model container
    @Query var books: [Book]
    
    //State to handle showing the form to add books from AddBookView
    @State var showingAddScreen = false
    
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
                                
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Book Worm")
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showingAddScreen.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
}

#Preview {
    ContentView()
}
