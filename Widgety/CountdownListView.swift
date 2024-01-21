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
                .padding([.top], 20)
        }
        .listRowInsets(EdgeInsets(top: 0,leading: 0,bottom: 0,trailing: 0))
        .listSectionSpacing(20)
    }
}



struct CountdownListView: View {
    @Binding var items: [Event]
    @Binding var selectedIndex: Int?

    var body: some View {
        List(selection: $selectedIndex) {
            DescriptiveSectionView(text: "You can show each countdown in its own widget. Make as many as you want!")
            Section{
                ForEach($items) { $item in
                    HStack {
                        Circle()
                            .fill(Theme.bgColor(theme: item.color))
                            .frame(width: 10 , height: 10)
                        Text(item.name)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedIndex = items.firstIndex(of: item)!
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

#Preview {
    HStack {
        @State var events = [Event(id: UUID(), name: "An Event", date: .now, color: .orange), Event(id: UUID(), name: "Another Event", date: .now, color: .red), Event(id: UUID(), name: "A third event", date: .now, color: .blue)]
        @State var selectedIndex: Int?
        
        CountdownListView(items: $events, selectedIndex: $selectedIndex)
        
    }
    
}

