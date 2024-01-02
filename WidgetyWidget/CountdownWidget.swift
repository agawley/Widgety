//
//  WidgetyWidget.swift
//  WidgetyWidget
//
//  Created by Alex Gawley on 05/11/2023.
//

import WidgetKit
import SwiftUI

struct CountdownProvider: TimelineProvider {
    
    private static let fallbackEntry = EventsTimelineEntry(date: .now, events: [Event(id: UUID(), name: "The default event", date: .now, color: .blue, repeating: .never)], index: 0)
    
    func placeholder(in context: Context) -> EventsTimelineEntry {
        (Events().items.first != nil) 
            ? EventsTimelineEntry(date: .now, events: Events().items, index: 0)
            : CountdownProvider.fallbackEntry
    }

    func getSnapshot(in context: Context, completion: @escaping (EventsTimelineEntry) -> Void) {
        completion(
            (Events().items.first != nil)
                ? EventsTimelineEntry(date: .now, events: Events().items, index: 0)
                : CountdownProvider.fallbackEntry
        )
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<EventsTimelineEntry>) -> Void) {
        var entries: [EventsTimelineEntry] = []
        let calendar = Calendar.current
        let events = Events().items
        
        let countdownOffset = UserDefaults(suiteName: "group.org.gawley.widgety")!.integer(forKey: NextCountdownIntent.offsetKey)
        
        // Generate a timeline consisting of seven entries a day apart, starting from the current date.
        let currentDate = Date()
        for dayOffset in 0 ..< 7 {
            let entryDate = calendar.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startOfDay = calendar.startOfDay(for: entryDate)
            let entry = (events.first != nil)
                ? EventsTimelineEntry(date: startOfDay, events: events, index: countdownOffset % events.count)
                : CountdownProvider.fallbackEntry
            entries.append(entry)
        }

        completion(Timeline(entries: entries, policy: .atEnd))
    }
}

struct CountdownWidgetEntryView : View {
    var entry: CountdownProvider.Entry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        switch family {
        case .systemSmall:
            CountdownSmallWidgetView(entry: entry)
       /* case .systemMedium:
            CountdownMediumWidgetView(entry: entry).widgetURL(URL(string: "widgety://countdowns"))*/
        default:
            Text("Unsupported")
        }
    }
}

struct CountdownWidget: Widget {
    let kind: String = "WidgetyWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: CountdownProvider()) { entry in
                let eventEntry = entry.events[entry.index].timelineEntry(entryDate: entry.date)
                CountdownWidgetEntryView(entry: entry)
                    .containerBackground( for: .widget) {
                        ContainerRelativeShape().fill(Theme.bgColor(theme:eventEntry.color)) }
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
    EventEntry(id: UUID(), name: "end of the world again", daysUntil: 1200, date: .now, color: ThemeColor.red)
    EventEntry(id: UUID(), name: "end of the world",daysUntil: 0, date: .now, color: ThemeColor.purple)
}
