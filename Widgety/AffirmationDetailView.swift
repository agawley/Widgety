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
                        VStack() {
                            Text("Preview").fontWeight(.bold)
                            HStack() {
                                Spacer()
                                HStack {
                                    AffirmationWidgetView(entry: AffirmationEntry(affirmations: items, date: .now, index: selectedIndex)).padding([.horizontal], 5)
                                }.frame(width: 160, height: 160).background(Theme.bgColor(theme: items[selectedIndex].color)).cornerRadius(25)
                                VStack(alignment: .leading) {
                                    Text("To install, go to your homescreen, long press and then tap the + button.").multilineTextAlignment(.leading).font(.caption)
                                    Spacer().frame(height: 10)
                                    Text("Tap the widget to cycle through affirmations. Or just wait til tomorrow!").multilineTextAlignment(.leading).font(.caption)
                                }.frame(maxWidth: 200)
                                
                                Spacer()
                            }
                        }.padding([.top,.bottom], 10)
                    }
                    
                    Spacer()
                    
                }
            } else {
                Text("Select an affirmation to preview / edit").font(.title)
            }
        }
        .navigationTitle(selectedIndex != nil ? "Edit affirmation" : "")
        .background(selectedIndex != nil ? Color(UIColor.systemGroupedBackground) : Color(UIColor.systemBackground))
    }
}

