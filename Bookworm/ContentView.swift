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
    // Sort will order the books by title and if there is any identical title then sort those by Author
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]
    
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
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Book Worm")
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
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
    
    //Delete book in querry trough swiping using the .onDelete(perform: ) in the list view.
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            //Find the book in the querry
            let book = books[offset]
            //Find the specified book in the modelContext and delete it.
            modelContext.delete(book)
        }
        
        
    }
}

#Preview {
    ContentView()
}
