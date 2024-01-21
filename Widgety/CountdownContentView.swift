//
//  ContentView.swift
//  Widgety
//
//  Created by Alex Gawley on 05/11/2023.
//

import SwiftUI

struct CountdownContentView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var columnVisibility: NavigationSplitViewVisibility = .automatic
    @State var events = Events.getDefault()

    @State private var selectedIndex: Int?

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            CountdownListView(items: $events.items, selectedIndex: $selectedIndex).navigationTitle("Countdowns")
        } detail: {
            CountdownDetailView(items: $events.items, selectedIndex: selectedIndex)
        }
        .navigationSplitViewStyle(.balanced)
        .onAppear() {
            updateColumnVisibility()
        }
        .onDisappear() {
            events.saveItems()
        }
        .onOpenURL  { url in
            guard let id = url.countdownIdentifier else {
              return
            }
            guard let index = events.items.firstIndex(where: { $0.id.uuidString == id }) else {
                return
            }
            selectedIndex = index
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
    CountdownContentView()
}
