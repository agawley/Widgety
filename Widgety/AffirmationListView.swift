//
//  AffirmationListView.swift
//  Widgety
//
//  Created by Alex Gawley on 16/12/2023.
//

import SwiftUI

struct AffirmationListView: View {
    
    @Binding var items: [Affirmation]
    @Binding var selectedIndex: Int?
    
    
    var body: some View {
        List(selection: $selectedIndex) {
            DescriptiveSectionView(text: "The Affirmation Widget will show a different phrase each day.")
            Section{
                ForEach(items.indices, id: \.self) { index in
                    HStack {
                        Circle()
                            .fill(Theme.bgColor(theme: items[index].color))
                            .frame(width: 10 , height: 10)
                        Text(items[index].phrase)
                    }.onTapGesture {
                        selectedIndex = index
                    }
                }.onDelete { index in
                    items.remove(atOffsets: index)
                }.onMove { from, to in
                    items.move(fromOffsets: from, toOffset: to)
                }
            }
            Button {
                withAnimation {
                    items.append(Affirmations.defaultAffirmations.randomElement()!)
                    selectedIndex = items.count - 1
                }
            } label: {
                Label("Add", systemImage: "plus")
            }
        }.id(UUID())
    }
}
