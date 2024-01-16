//
//  WidgetyApp.swift
//  Widgety
//
//  Created by Alex Gawley on 05/11/2023.
//

import SwiftUI
import WidgetKit

enum TabIdentifier: Hashable {
  case countdowns, affirmations
}

extension URL {
  var isDeeplink: Bool {
    return scheme == "widgety"
  }

  var tabIdentifier: TabIdentifier? {
    guard isDeeplink else { return nil }

    switch host {
    case "countdowns": return .countdowns
    case "affirmations": return .affirmations
    default: return nil
    }
  }
    
    var countdownIdentifier: String? {
        guard tabIdentifier == .countdowns else { return nil }
        return query()
    }
}


@main
struct WidgetyApp: App {
    @Environment(\.scenePhase) var scenePhase
    @State var activeTab = TabIdentifier.countdowns
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $activeTab) {
                CountdownContentView()
                    .tabItem {
                        Label("Countdowns", systemImage: "clock.arrow.circlepath")
                    }.tag(TabIdentifier.countdowns)
                AffirmationContentView()
                    .tabItem {
                        Label("Affirmations", systemImage: "heart")
                    }.tag(TabIdentifier.affirmations)
            }.onOpenURL { url in
                guard let tabIdentifier = url.tabIdentifier else {
                  return
                }
                activeTab = tabIdentifier
            }
        }.onChange(of: scenePhase) {
            if scenePhase == .background {
                Affirmations.defaults.saveItems()
                Events.getDefault().saveItems()
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
    }
    
    
}
