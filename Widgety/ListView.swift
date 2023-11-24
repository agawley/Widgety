//
//  ListView.swift
//  Widgety
//
//  Created by Alex Gawley on 23/11/2023.
//

import SwiftUI

struct ListView: View {
    @Binding var items: [Event]
    @Binding var selectedIndex: Int?

    var body: some View {
        List(selection: $selectedIndex) {
            Section{
                ForEach(items.indices, id: \.self) { index in
                    HStack {
                        Circle()
                            .fill(Theme.bgColor(theme: items[index].color))
                            .frame(width: 10 , height: 10)
                        Text(items[index].name)
                    }.onTapGesture {
                        selectedIndex = index
                    }
                }
            }
            Button {
                withAnimation {
                    items.append(Event(id:UUID(), name: "My new event", date: Date(), color: ThemeColor.allCases.randomElement()!))
                    selectedIndex = items.count - 1
                }
            } label: {
                Label("Add", systemImage: "plus")
            }
        }
    }
}
