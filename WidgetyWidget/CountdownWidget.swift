//
//  WidgetyWidget.swift
//  WidgetyWidget
//
//  Created by Alex Gawley on 05/11/2023.
//

import WidgetKit
import SwiftUI

struct CountdownProvider: AppIntentTimelineProvider {
    
    private static let fallbackEntry = EventEntry(id: UUID(), name: "something amazing", daysUntil:314, date: .now, color: ThemeColor.blue)
    
    func placeholder(in context: Context) -> EventEntry {
        Events().items.first?.timelineEntry(entryDate: .now) ?? CountdownProvider.fallbackEntry
    }

    func snapshot(for configuration: CountdownWidgetConfigurationAppIntent, in context: Context) async -> EventEntry {
        Events().items.first?.timelineEntry(entryDate: .now) ?? CountdownProvider.fallbackEntry
    }
    
    func timeline(for configuration: CountdownWidgetConfigurationAppIntent, in context: Context) async -> Timeline<EventEntry> {
        print(context)
        var entries: [EventEntry] = []
        let calendar = Calendar.current
        
        // Generate a timeline consisting of seven entries a day apart, starting from the current date.
        let currentDate = Date()
        for dayOffset in 0 ..< 7 {
            let entryDate = calendar.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startOfDay = calendar.startOfDay(for: entryDate)
            let tenMinOffsetFromMidnight = calendar.date(byAdding: .minute, value: 10, to: startOfDay)!
            let entry = configuration.event?.timelineEntry(entryDate: tenMinOffsetFromMidnight) ??  EventEntry(id: UUID(), name: EventEntry.NO_OPTION_NAME, daysUntil:0, date: .now, color: ThemeColor.grey)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct CountdownWidgetEntryView : View {
    var entry: CountdownProvider.Entry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        switch family {
        case .systemSmall:
            CountdownSmallWidgetView(entry: entry).widgetURL(URL(string: "widgety://countdowns?\(entry.id.uuidString)"))
        case .systemMedium:
            CountdownMediumWidgetView(entry: entry).widgetURL(URL(string: "widgety://countdowns"))
        default:
            Text("Unsupported")
        }
    }
}

struct CountdownWidget: Widget {
    let kind: String = "WidgetyWidget"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: CountdownWidgetConfigurationAppIntent.self,
            provider: CountdownProvider()) { entry in
                CountdownWidgetEntryView(entry: entry)
                    .containerBackground( for: .widget) {
                        ContainerRelativeShape().fill(Theme.bgColor(theme:entry.color)) }
            }
            .configurationDisplayName("Countdown")
            .description("Countdown towards your important dates")
            .supportedFamilies([.systemSmall, .systemMedium])
            .contentMarginsDisabled()
    }
}

#Preview(as: .systemMedium) {
    CountdownWidget()
} timeline: {
    EventEntry(id: UUID(), name: "end of the world again", daysUntil: 1200, date: .now, color: ThemeColor.orange)
    EventEntry(id: UUID(), name: "end of the world",daysUntil: 0, date: .now, color: ThemeColor.purple)
}
