//
//  WidgetyWidget.swift
//  WidgetyWidget
//
//  Created by Alex Gawley on 05/11/2023.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    
    func placeholder(in context: Context) -> EventEntry {
        EventEntry(eventName: "end of the world", daysUntil: 1203, date: .now, color: ThemeColor.blue)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> EventEntry {
        let eventName: String = configuration.event.eventName
        let eventDate:Date = configuration.event.date
        let currentDate = Date()
        return EventEntry(eventName: eventName, daysUntil: Event.daysUntilEvent(eventDate: eventDate, fromDate: currentDate), date: Date(), color: configuration.event.color)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<EventEntry> {
        var entries: [EventEntry] = []
        let eventName: String = configuration.event.eventName
        let eventDate:Date = configuration.event.date
        let calendar = Calendar.current
        
        // Generate a timeline consisting of seven entries a day apart, starting from the current date.
        let currentDate = Date()
        for dayOffset in 0 ..< 7 {
            let entryDate = calendar.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startOfDay = calendar.startOfDay(for: entryDate)
            let entry = EventEntry(eventName: eventName, daysUntil: Event.daysUntilEvent(eventDate: eventDate, fromDate: currentDate), date: startOfDay,  color: configuration.event.color)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct EventEntry: TimelineEntry {
    let eventName: String
    let daysUntil: Int
    let date: Date
    let color: ThemeColor
}

struct WidgetyWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            Text(entry.daysUntil.formatted()).font(.system(size:60, weight:.heavy, design: .rounded)).foregroundColor(Theme.textColor(theme:entry.color))
                .minimumScaleFactor(0.6)
            Text("days until").foregroundColor(Theme.textColor(theme:entry.color))
            Spacer()
            Text(entry.eventName.lowercased()).font(.system(.title3, design: .rounded)).foregroundColor(Theme.textColor(theme:entry.color)).fontWeight(.bold)
                .multilineTextAlignment(.center).minimumScaleFactor(0.6)
        }
    }
}

struct WidgetyWidget: Widget {
    let kind: String = "WidgetyWidget"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WidgetyWidgetEntryView(entry: entry)
                .containerBackground( for: .widget) {
                    ContainerRelativeShape().fill(Theme.bgColor(theme:entry.color)) }
        }.supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    WidgetyWidget()
} timeline: {
    EventEntry(eventName: "end of the world", daysUntil: 1201, date: .now, color: ThemeColor.red)
    EventEntry(eventName: "end of the world", daysUntil: 1201, date: .now, color: ThemeColor.purple)
}
