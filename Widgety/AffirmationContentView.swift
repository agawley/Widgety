//
//  AffirmationContentView.swift
//  Widgety
//
//  Created by Alex Gawley on 16/12/2023.
//

import SwiftUI

import SwiftUI

struct AffirmationContentView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var columnVisibility: NavigationSplitViewVisibility = .automatic
    @State var affirmations = Affirmations.defaults

    @State private var selectedIndex: Int?

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            AffirmationListView(items: $affirmations.items, selectedIndex: $selectedIndex).navigationTitle("Affirmations")
        } detail: {
            AffirmationDetailView(items: $affirmations.items, selectedIndex: selectedIndex)
                .navigationTitle(selectedIndex != nil ? "Edit affirmation" : "")
                .navigationBarTitleDisplayMode(.inline)
        }
        .navigationSplitViewStyle(.balanced)
        .onAppear() {
            updateColumnVisibility()
        }
        .onDisappear() {
            affirmations.saveItems()
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
    AffirmationContentView()
}
