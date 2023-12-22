//
//  ListView.swift
//  Widgety
//
//  Created by Alex Gawley on 23/11/2023.
//

import SwiftUI

struct DescriptiveSectionView: View {
    var text: String
    
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        Section {
            Text(text)
                .font(.subheadline)
                .listRowBackground(colorScheme == .dark ? Color(.systemBackground) : Color(.secondarySystemBackground))
                .padding([.horizontal], 0)
        }.listRowInsets(EdgeInsets(top: 0,leading: 0,bottom: 0,trailing: 0))
    }
}



struct ListView: View {
    @Binding var items: [Event]
    @Binding var selectedIndex: Int?

    var body: some View {
        List(selection: $selectedIndex) {
            DescriptiveSectionView(text: "You can show each countdown in its own widget. Make as many as you want!")
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
                }.onDelete { index in
                    items.remove(atOffsets: index)
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
