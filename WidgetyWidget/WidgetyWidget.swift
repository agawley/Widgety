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
        Event.allEvents().last!.timelineEntry(entryDate: .now)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> EventEntry {
        Event.allEvents().last!.timelineEntry(entryDate: .now)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<EventEntry> {
        print(configuration.event)
        var entries: [EventEntry] = []
        let calendar = Calendar.current
        
        // Generate a timeline consisting of seven entries a day apart, starting from the current date.
        for dayOffset in 0 ..< 7 {
            let entryDate = calendar.date(byAdding: .day, value: dayOffset, to: .now)!
            let startOfDay = calendar.startOfDay(for: entryDate)
            let entry = configuration.event.timelineEntry(entryDate: startOfDay) 
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
    EventEntry(name: "end of the world again", date: .now)
    EventEntry(name: "end of the world", date: .now)
}
