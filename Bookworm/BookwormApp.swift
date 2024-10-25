//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Pau Valverde Molina on 10/21/24.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        //Make the Student model available everywhere in the appp
        .modelContainer(for: Book.self)
    }
}
