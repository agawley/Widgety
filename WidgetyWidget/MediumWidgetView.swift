//
//  SmallWidgetView.swift
//  Widgety
//
//  Created by Alex Gawley on 08/11/2023.
//

import SwiftUI

struct MediumWidgetView: View {
    
    private func timingString(from event: EventEntry) -> String {
        var timingString: String = ""
        let days = event.daysUntil
        let longFormTimeUntil = WeeksDaysHours(weeks: days / 7, days: days % 7, hours: 0)
        if (longFormTimeUntil.weeks > 0) {
            timingString += longFormTimeUntil.weeks.formatted()
            timingString += longFormTimeUntil.weeks == 1 ? " week" : " weeks"
            timingString += longFormTimeUntil.days > 0 ? " " : ""
        }
        if (longFormTimeUntil.days > 0) {
            timingString += longFormTimeUntil.days.formatted()
            timingString += longFormTimeUntil.days == 1 ? " day" : " days"
        }
        return timingString
    }
    
    var entry: EventEntry?
    
    var body: some View {
        if let event = entry {
            if (event.name == EventEntry.NO_OPTION_NAME) {
                    Text("Long press to setup widget")
                        .font(.system(size:20, weight:.heavy, design: .rounded))
                        .foregroundColor(Theme.textColor(theme:event.color))
            } else if event.daysUntil == 0 {
                VStack {
                    Text(event.name).font(.system(.title3, design: .rounded)).foregroundColor(Theme.textColor(theme:event.color)).fontWeight(.bold)
                        .multilineTextAlignment(.center).minimumScaleFactor(0.6).padding([.bottom], 10)
                    Text("is TODAY!").font(.system(.title2, design: .rounded)).foregroundColor(Theme.textColor(theme:event.color)).fontWeight(.bold)
                        .minimumScaleFactor(0.6)
                }
            } else {
                VStack(spacing:0) {
                    Text(timingString(from: event))
                        .font(.system(size:40, weight:.heavy,design: .rounded))
                        .foregroundColor(Theme.textColor(theme:event.color))
                        .layoutPriority(2)
                        .lineLimit(1)
                        .frame(height: 50, alignment: .center)
                    HStack(alignment: .center) {
                        Text(event.daysUntil < 0 ? "since" : "until" )
                            .font(.title2)
                            .foregroundColor(Theme.textColor(theme:event.color))
                            .frame(maxHeight: .infinity, alignment: .center)
                            .padding(.top, 5)
                    }
                    Text(event.name)
                        .font(.system(size:30, weight:.heavy, design: .rounded))
                        .foregroundColor(Theme.textColor(theme:event.color))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.6)
                        .frame(height: 50, alignment: .center)
                        .layoutPriority(1)
                }.padding(20)
            }
        } else {
            Text("Open the app to create an event")
        }
    }
}

#Preview {
    HStack{
        MediumWidgetView(entry: EventEntry(name: "end of term - yay!", daysUntil: 500, date: .now, color: ThemeColor.red))
    }.frame(width: 350, height: 175).background(.red).cornerRadius(25)
}

