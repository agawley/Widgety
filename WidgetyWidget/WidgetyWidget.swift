//
//  WidgetyWidget.swift
//  WidgetyWidget
//
//  Created by Alex Gawley on 05/11/2023.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(eventName: "end of the world", daysUntil: 1203, date: .now)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        let eventName: String = configuration.event.eventName
        let eventDate:Date = configuration.event.date
        let currentDate = Date()
        return SimpleEntry(eventName: eventName, daysUntil: daysUntilEvent(eventDate: eventDate, currentDate: currentDate), date: Date())
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        let eventName: String = configuration.event.eventName
        let eventDate:Date = configuration.event.date
        let calendar = Calendar.current
        
        // Generate a timeline consisting of seven entries a day apart, starting from the current date.
        let currentDate = Date()
        for dayOffset in 0 ..< 7 {
            let entryDate = calendar.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startOfDay = calendar.startOfDay(for: entryDate)
            let entry = SimpleEntry(eventName: eventName, daysUntil: daysUntilEvent(eventDate: eventDate, currentDate: currentDate), date: startOfDay)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

func daysUntilEvent(eventDate: Date, currentDate: Date) -> Int {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day], from: calendar.startOfDay(for: currentDate), to: calendar.startOfDay(for: eventDate))
    return components.day!
}

struct SimpleEntry: TimelineEntry {
    let eventName: String
    let daysUntil: Int
    let date: Date
}

struct WidgetyWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack{
            Text(entry.daysUntil.formatted()).font(.system(size:60, weight:.heavy, design: .rounded)).foregroundColor(.white)
                .minimumScaleFactor(0.6)
            Text("days until").foregroundColor(.white.opacity(0.9))
            Spacer()
            Text(entry.eventName.lowercased()).font(.system(.title3, design: .rounded)).foregroundColor(.white).fontWeight(.bold)
                .multilineTextAlignment(.center)
                
        }
    }
}

struct WidgetyWidget: Widget {
    let kind: String = "WidgetyWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WidgetyWidgetEntryView(entry: entry)
                .containerBackground( for: .widget) { ContainerRelativeShape().fill(.blue.gradient) }
                
        }
    }
}

#Preview(as: .systemSmall) {
    WidgetyWidget()
} timeline: {
    SimpleEntry(eventName: "end of the world", daysUntil: 1201, date: .now)
    SimpleEntry(eventName: "end of the world", daysUntil: 1201, date: .now)
}
