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
        EventEntry(name: "something amazng", daysUntil: 314, date: .now, color: ThemeColor.blue)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> EventEntry {
        EventEntry(name: "something mazing", daysUntil:314, date: .now, color: ThemeColor.blue)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<EventEntry> {
        print(context)
        var entries: [EventEntry] = []
        let calendar = Calendar.current
        
        // Generate a timeline consisting of seven entries a day apart, starting from the current date.
        let currentDate = Date()
        for dayOffset in 0 ..< 7 {
            let entryDate = calendar.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startOfDay = calendar.startOfDay(for: entryDate)
            let entry = configuration.event?.timelineEntry(entryDate: startOfDay) ??  Events().items.last?.timelineEntry(entryDate: Date()) ?? EventEntry(name: "tap to make a new event", daysUntil:0, date: .now, color: ThemeColor.blue)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct WidgetyWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        SmallWidgetView(entry: entry)
    }
}

struct WidgetyWidget: Widget {
    let kind: String = "WidgetyWidget"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: ConfigurationAppIntent.self,
            provider: Provider()) { entry in
                WidgetyWidgetEntryView(entry: entry)
                    .containerBackground( for: .widget) {
                        ContainerRelativeShape().fill(Theme.bgColor(theme:entry.color)) }
            }
            .configurationDisplayName("Countdown")
            .description("Countdown towards your important dates")
            .supportedFamilies([.systemSmall, .systemMedium])
            .contentMarginsDisabled()
    }
}

#Preview(as: .systemSmall) {
    WidgetyWidget()
} timeline: {
    EventEntry(name: "end of the world again", daysUntil: 1200, date: .now, color: ThemeColor.red)
    EventEntry(name: "end of the world", daysUntil: 0, date: .now, color: ThemeColor.purple)
}
