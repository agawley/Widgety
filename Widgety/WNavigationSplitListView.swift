//
//  WNavigationSplitView.swift
//  Widgety
//
//  Created by Alex Gawley on 22/01/2024.
//

import SwiftUI

struct WNavigationSplitListView<T: Identifiable & Hashable & Codable, ItemContent: View, DetailContent: View>: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var columnVisibility: NavigationSplitViewVisibility = .automatic
    
    @Binding var items: [T]
    @Binding var selectedIndex: Int?
    let title: String
    let detailTitle: String
    let description: String
    let defaultItem: () -> T
    let itemView: (_ item: T) -> ItemContent
    let detailView: () -> DetailContent
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            WListView(
                items: $items,
                selectedIndex: $selectedIndex,
                description: description,
                defaultItem: defaultItem,
                ItemView: itemView
            ).navigationTitle(title)
        } detail: {
            detailView()
                .navigationTitle(selectedIndex != nil ? detailTitle : "")
                .navigationBarTitleDisplayMode(.inline)
        }
        .navigationSplitViewStyle(.balanced)
        .onAppear() {
            updateColumnVisibility()
        }
        .onDisappear() {
            //TODO
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
