//
//  DetailView.swift
//  Bookworm
//
//  Created by Pau Valverde Molina on 10/23/24.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    
    let book: Book
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre.uppercased())
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.5))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
            
            Text (book.review)
                .padding()
            
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete Book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button("Delete this book", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
    }
    
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    //With Swift Data is not as simple as passing around am example book. We need to make our model container by hand, using ModelConfiguration to request temporary in-memory storage. Then have a ModelContainer to have the Book object send to the view.
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for:Book.self, configurations: config)
        let example = Book(title: "Test Book", author: "Test Author", genre: "Fantasy", review: "Great Book, sligthyly better than the previous one", rating: 3)
      
        return DetailView(book: example)
            .modelContainer(container)
    } catch {
        return Text("Could not  generate preview: ! \(error.localizedDescription)")
    }
}
