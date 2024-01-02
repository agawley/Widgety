//
//  DetailView.swift
//  Widgety
//
//  Created by Alex Gawley on 06/11/2023.
//

import SwiftUI

struct ClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        
        HStack {
            content
            if !text.isEmpty {
                Button {
                    text = ""
                }label: {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 10)
            }
        }
    }
}

extension View {
    func clearButton(text: Binding<String>) -> some View {
        modifier(ClearButton(text: text))
    }
}

struct CountdownDetailView: View {
    @Binding var items: [Event]
    var selectedIndex: Int?
    
    var body: some View {
        Group {
            if let selectedIndex = selectedIndex {
                VStack() {
                    Form {
                        TextField("Name", text: $items[selectedIndex].name)
                            .clearButton(text: $items[selectedIndex].name)
                        DatePicker(selection: $items[selectedIndex].date, displayedComponents: .date) {
                            Text("Date")
                        }
                        Picker("Color", selection: $items[selectedIndex].color) {
                            ForEach(ThemeColor.allCases) { c in
                                Text(c.rawValue.capitalized)
                            }
                        }
                        Picker("Repeats", selection: $items[selectedIndex].repeating) {
                            ForEach(RepeatOptions.allCases) { o in
                                Text(o.rawValue.capitalized)
                            }
                        }
//                        HStack() {
//                            Spacer()
//                            HStack {
//                                CountdownSmallWidgetView(entry: items[selectedIndex].timelineEntry(entryDate: Date())).padding([.horizontal], 5).padding([.vertical], 10)
//                            }.frame(width: 175, height: 175).background(Theme.bgColor(theme: items[selectedIndex].color)).cornerRadius(25)
//                            VStack(alignment: .leading) {
//                                Text("Widget preview").fontWeight(.bold).multilineTextAlignment(.leading)
//                                Text("To install, go to your homescreen, long press and then tap the + button.").multilineTextAlignment(.leading).font(.caption)
//                                Text("Then 'Edit Widget' and select this event.").multilineTextAlignment(.leading).font(.caption)
//                            }.frame(maxWidth: 200)
//                            
//                            Spacer()
//                        }.padding([.top,.bottom], 20)
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
