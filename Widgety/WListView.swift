//
//  WListView.swift
//  Widgety
//
//  Created by Alex Gawley on 22/01/2024.
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


struct WListView<T: Identifiable & Hashable & Codable, Content: View>: View {
    @Binding var items: [T]
    @Binding var selectedIndex: Int?
    let description: String
    let defaultItem: () -> T
    let ItemView: (_ item: T) -> Content

    var body: some View {
        List(selection: $selectedIndex) {
            DescriptiveSectionView(text: description)
            Section{
                ForEach(items) { item in
                    HStack {
                        ItemView(item)
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
                    items.append(defaultItem())
                    selectedIndex = items.count - 1
                }
            } label: {
                Label("Add", systemImage: "plus")
            }
        }
    }
}
