//
//  AffirmationContentView.swift
//  Widgety
//
//  Created by Alex Gawley on 16/12/2023.
//

import SwiftUI

import SwiftUI

struct AffirmationContentView: View {
    @State var affirmations = Affirmations.defaults

    @State private var selectedIndex: Int?

    var body: some View {
        WNavigationSplitListView(
            items: $affirmations.items,
            selectedIndex: $selectedIndex,
            title: "Affirmations",
            detailTitle: "Edit affirmation",
            description: "The Affirmation Widget will show a different phrase each day.",
            defaultItem: { Affirmations.defaultAffirmations.randomElement()! }) { item in
                HStack {
                    Circle()
                        .fill(Theme.bgColor(theme: item.color))
                        .frame(width: 10 , height: 10)
                    Text(item.phrase)
                }
            } detailView: {
                AffirmationDetailView(items: $affirmations.items, selectedIndex: selectedIndex)
            }
            .onDisappear() {
                affirmations.saveItems()
            }
    }
    
}


#Preview {
    AffirmationContentView()
}
