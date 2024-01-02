//
//  SmallWidgetView.swift
//  Widgety
//
//  Created by Alex Gawley on 08/11/2023.
//

import SwiftUI


struct CountdownToggleStyle: ToggleStyle {
    var entry: EventsTimelineEntry
    
    func makeBody(configuration: Configuration) -> some View {
        let currentEvent = entry.events[entry.index]
        let nextEvent = entry.events[(entry.index + 1) % entry.events.count]
        configuration.isOn
            ? CountdownSmallWidgetInnerView(event:nextEvent.timelineEntry(entryDate: entry.date))
            : CountdownSmallWidgetInnerView(event:currentEvent.timelineEntry(entryDate: entry.date))
    }
}

struct CountdownSmallWidgetView: View {
    var entry: EventsTimelineEntry
    
    var body: some View {
        ZStack {
            Toggle(isOn: false, intent: NextCountdownIntent()) {
                Text("Not shown")
            }.toggleStyle(CountdownToggleStyle(entry: entry)).frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct CountdownSmallWidgetInnerView: View {
    var event: EventEntry
    
    var body: some View {
        ZStack {
                ZStack {
                    if (event.tag == .xmas) {
                        Image("tree")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
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
                            .padding([.horizontal], 10)
                    } else if event.daysUntil == 0 {
                        VStack(spacing:5) {
                            Text(event.name)
                                .font(.system(size:30, weight:.heavy,design: .rounded))
                                .foregroundColor(Theme.textColor(theme:event.color))
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.6)
                            Text("is")
                                .font(.system(size:20,design: .rounded))
                                .foregroundColor(Theme.textColor(theme:event.color))
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.6)
                            Text("TODAY!")
                                .font(.system(size:30, weight:.heavy,design: .rounded))
                                .foregroundColor(Theme.textColor(theme:event.color))
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.6)
                        }.padding(20)
                    } else {
                        VStack(spacing:0) {
                            Text(abs(event.daysUntil).formatted())
                                .font(.system(size:abs(event.daysUntil) > 999 ? 40 : 55, weight:.heavy,design: .rounded))
                                .foregroundColor(Theme.textColor(theme:event.color))
                                .layoutPriority(2)
                                .lineLimit(1)
                                .frame(height: 50, alignment: .center)
                            
                            HStack(alignment: .center) {
                                Text(event.daysUntil < 0 ? (event.daysUntil == -1 ? "day since" : "days since") : event.daysUntil == 1 ? "day until" : "days until" )
                                    .foregroundColor(Theme.textColor(theme:event.color))
                                    .frame(maxHeight: .infinity, alignment: .center)
                                    .padding(.top, 5)
                            }
                            Text(event.name)
                                .font(.system(size:28, weight:.heavy, design: .rounded))
                                .foregroundColor(Theme.textColor(theme:event.color))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.4)
                                .frame(height: 50, alignment: .center)
                                .layoutPriority(1)
                        }.padding(20)
                    }
                }
        }
    }
}

