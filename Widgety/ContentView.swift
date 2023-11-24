//
//  ContentView.swift
//  Widgety
//
//  Created by Alex Gawley on 05/11/2023.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var columnVisibility: NavigationSplitViewVisibility = .automatic
    @State var events = Events.getDefault().items

    @State private var selectedIndex: Int?

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            ListView(items: $events, selectedIndex: $selectedIndex).navigationTitle("Countdowns")
        } detail: {
            DetailView(items: $events, selectedIndex: selectedIndex)
        }
        .navigationSplitViewStyle(.balanced)
        .onChange(of: scenePhase) {
            if scenePhase == .background {
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
        .onAppear() {
            updateColumnVisibility()
        }
    }
    
    private func updateColumnVisibility() {
            if UIDevice.current.userInterfaceIdiom == .pad {
                // On iPad, use double column layout
                columnVisibility = .doubleColumn
            } else {
                // In all other cases, let SwiftUI decide automatically
                columnVisibility =  .automatic
            }
        }
}


#Preview {
    ContentView()
}
