//
//  SDIntroductionApp.swift
//  SDIntroduction
//
//  Created by Tan Xin Jie on 4/2/25.
//

import SwiftUI
import SwiftData

@main
struct SDIntroductionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
