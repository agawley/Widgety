//
//  SmallWidgetView.swift
//  Widgety
//
//  Created by Alex Gawley on 08/11/2023.
//

import SwiftUI
import WidgetKit

struct CountdownMediumWidgetView: View {
    
    private func timingString(from event: EventEntry) -> String {
        var timingString: String = ""
        let days = event.daysUntil
        let longFormTimeUntil = WeeksDaysHours(weeks: days / 7, days: days % 7, hours: 0)
        if (abs(longFormTimeUntil.weeks) > 0) {
            timingString += abs(longFormTimeUntil.weeks).formatted()
            timingString += abs(longFormTimeUntil.weeks) == 1 ? " week" : " weeks"
            timingString += abs(longFormTimeUntil.days) > 0 ? " " : ""
        }
        if (abs(longFormTimeUntil.days) > 0) {
            timingString += abs(longFormTimeUntil.days).formatted()
            timingString += abs(longFormTimeUntil.days) == 1 ? " day" : " days"
        }
        return timingString
    }
    
    var entry: EventEntry?
    
    var body: some View {
        ZStack {
            if let event = entry {
                ZStack {
                    if (event.tag == .xmas) {
                        Image("tree")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .mask(Image("tree"))
                            .colorInvert()
                            .opacity(0.3)
                            .padding(13)
                    }
                    if (event.name == EventEntry.NO_OPTION_NAME) {
                        Text("Tap to add an event or tap and hold to configuire")
                            .font(.system(size:20, weight:.heavy, design: .rounded))
                            .foregroundColor(Theme.textColor(theme:event.color))
                            .multilineTextAlignment(.center)
                    } else if event.daysUntil == 0 {
                        VStack(spacing:0) {
                            Text(event.name)
                                .font(.system(size:40, weight:.heavy,design: .rounded))
                                .foregroundColor(Theme.textColor(theme:event.color))
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.6)
                                .padding([.bottom], 10)
                            Text("is TODAY!")
                                .font(.system(size:40, weight:.heavy,design: .rounded))
                                .foregroundColor(Theme.textColor(theme:event.color))
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.6)
                        }.padding(20)
                    } else {
                        VStack(spacing:0) {
                            Text(timingString(from: event))
                                .font(.system(size:40, weight:.heavy,design: .rounded))
                                .foregroundColor(Theme.textColor(theme:event.color))
                                .layoutPriority(2)
                                .lineLimit(1)
                                .frame(height: 50, alignment: .center)
                                .minimumScaleFactor(0.6)
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
                }
            } else {
                Text("Open the app to create an event")
            }
        }
    }
}

