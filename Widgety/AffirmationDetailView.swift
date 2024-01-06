//
//  AffirmationDetailView.swift
//  Widgety
//
//  Created by Alex Gawley on 16/12/2023.
//

import SwiftUI

struct AffirmationDetailView: View {
    @Binding var items: [Affirmation]
    var selectedIndex: Int?
    
    var body: some View {
        Group {
            if let selectedIndex = selectedIndex {
                VStack() {
                    Form {
                        TextField("Name", text: $items[selectedIndex].phrase)
                            .clearButton(text: $items[selectedIndex].phrase)
                        Picker("Color", selection: $items[selectedIndex].color) {
                            ForEach(ThemeColor.allCases) { c in
                                Text(c.rawValue.capitalized)
                            }
                        }
                        HStack() {
                            Spacer()
                            HStack {
                                AffirmationWidgetView(entry: AffirmationEntry(affirmations: items, date: .now, index: selectedIndex)).padding([.horizontal], 5).padding([.vertical], 10)
                            }.frame(width: 175, height: 175).background(Theme.bgColor(theme: items[selectedIndex].color)).cornerRadius(25)
                            VStack(alignment: .leading) {
                                Text("Widget preview").fontWeight(.bold).multilineTextAlignment(.leading)
                                Text("To install, go to your homescreen, long press and then tap the + button.").multilineTextAlignment(.leading).font(.caption)
                            }.frame(maxWidth: 200)
                            
                            Spacer()
                        }.padding([.top,.bottom], 20)
                    }
                    
                    Spacer()
                    
                }
            } else {
                Text("Select an event to preview / edit").font(.title)
            }
        }
        .navigationTitle(selectedIndex != nil ? "Edit event" : "")
        .background(selectedIndex != nil ? Color(UIColor.systemGroupedBackground) : Color(UIColor.systemBackground))
    }
}

