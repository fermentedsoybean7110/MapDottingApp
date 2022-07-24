//
//  MapDottingAppApp.swift
//  MapDottingApp
//

import SwiftUI

@main
struct MapDottingAppApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel())
        }
    }
}
