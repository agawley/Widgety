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
        WNavigationSplitListView(
            items: $events.items,
            selectedIndex: $selectedIndex,
            title: "Countdowns",
            detailTitle: "Edit countdown",
            description: "You can show each countdown in its own widget. Make as many as you want!",
            defaultItem: { Event(id:UUID(), name: "My new event", date: Date(), color: ThemeColor.allCases.randomElement()!) }) { item in
                HStack {
                    Circle()
                        .fill(Theme.bgColor(theme: item.color))
                        .frame(width: 10 , height: 10)
                    Text(item.name)
                }
            } detailView: {
                CountdownDetailView(items: $events.items, selectedIndex: selectedIndex)
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
            .onDisappear() {
                events.saveItems()
            }
    }

}


#Preview {
    CountdownContentView()
}
