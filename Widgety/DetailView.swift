//
//  DetailView.swift
//  Widgety
//
//  Created by Alex Gawley on 06/11/2023.
//

import SwiftUI


struct DetailView: View {
    @Binding var event: Event
    var body: some View {
        VStack {
            List {
                TextField("name", text: $event.name)
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
                Text(Event.daysUntilEvent(eventDate: event.date, fromDate: Date()).formatted()).font(.system(size:60, weight:.heavy, design: .rounded)).foregroundColor(Theme.textColor(theme:event.color))
                    .minimumScaleFactor(0.6)
                Text("days until").foregroundColor(Theme.textColor(theme:event.color))
                Text(event.name.lowercased()).font(.system(.title3, design: .rounded)).foregroundColor(Theme.textColor(theme:event.color)).fontWeight(.bold)
                    .multilineTextAlignment(.center).minimumScaleFactor(0.6)
            }.frame(width: 150, height: 150).background(Theme.bgColor(theme: event.color)).cornerRadius(15)
            Spacer()
        }.background(Color(UIColor.systemGroupedBackground))
    }
}
