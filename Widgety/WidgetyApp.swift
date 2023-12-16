//
//  WidgetyApp.swift
//  Widgety
//
//  Created by Alex Gawley on 05/11/2023.
//

import SwiftUI
import WidgetKit

@main
struct WidgetyApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Label("Countdowns", systemImage: "clock.arrow.circlepath")
                    }
                AffirmationContentView()
                    .tabItem {
                        Label("Affirmations", systemImage: "heart")
                    }
            }
        }.onChange(of: scenePhase) {
            if scenePhase == .background {
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
    }
    
    
}
