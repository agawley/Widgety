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
            }
            HStack {
                SmallWidgetView(entry: event.timelineEntry(entryDate: Date())).padding([.horizontal], 10).padding([.vertical], 10)
            }.frame(width: 175, height: 175).cornerRadius(25)
        }.background(Color(UIColor.systemGroupedBackground))
    }
}
