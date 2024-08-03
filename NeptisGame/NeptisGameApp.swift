//
//  NeptisGameApp.swift
//  NeptisGame
//
//  Created by Harun Begic on 29. 7. 2024..
//

import SwiftUI

@main
struct NeptisGameApp: App {
    @StateObject private var viewModel = UserViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)  // Inject the view model into the environment
        }
    }
}

