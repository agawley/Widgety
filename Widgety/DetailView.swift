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

struct DetailView: View {
    @Binding var event: Event
    var body: some View {
        VStack {
            List {
                TextField("name", text: $event.name).clearButton(text: $event.name)
                DatePicker(selection: $event.date, displayedComponents: .date) {
                    Text("Date")
                }
                Picker("Color", selection: $event.color) {
                    ForEach(ThemeColor.allCases) { c in
                        Text(c.rawValue.capitalized)
                    }
                }
            }
            VStack {
                SmallWidgetView(entry: event.timelineEntry(entryDate: Date())).padding([.horizontal], 30).padding([.vertical], 20)
            }.frame(width: 150, height: 150).background(Theme.bgColor(theme: event.color)).cornerRadius(25).padding(30)
        }.background(Color(UIColor.systemGroupedBackground))
    }
}
