//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Tan Xin Jie on 3/2/25.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Book.self)
        }
    }
}
