//
//  AffirmationWidget.swift
//  WidgetyWidgetExtension
//
//  Created by Alex Gawley on 16/12/2023.
//

import WidgetKit
import SwiftUI

struct AffirmationProvider: TimelineProvider {
    
    private static let fallbackEntry = AffirmationEntry(affirmations: [Affirmation(id: UUID(), phrase: "You are a queen",  color: ThemeColor.blue)], date: .now, index: 0)
    
    func placeholder(in context: Context) -> AffirmationEntry {
        (Affirmations().items.first != nil) 
        ? AffirmationEntry(affirmations: Affirmations().items, date: .now, index: 0)
        : AffirmationProvider.fallbackEntry
    }
    
    func getSnapshot(in context: Context, completion: @escaping (AffirmationEntry) -> Void) {
        completion(
            (Affirmations().items.first != nil)
            ? AffirmationEntry(affirmations: Affirmations().items, date: .now, index: 0)
            : AffirmationProvider.fallbackEntry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<AffirmationEntry>) -> Void) {
        var entries: [AffirmationEntry] = []
        let affirmations = Affirmations().items
        let calendar = Calendar.current
        
        let affirmationOffset = UserDefaults(suiteName: "group.org.gawley.widgety")!.integer(forKey: NextAffirmationIntent.offsetKey)
        
        // Generate a timeline consisting of seven entries a day apart, starting from the current date.
        let currentDate = Date()
        for dayOffset in 0 ..< affirmations.count {
            let entryDate = calendar.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startOfDay = calendar.startOfDay(for: entryDate)
            let day = calendar.dateComponents([.day], from: entryDate).day ?? 0
            let entry = AffirmationEntry(affirmations: affirmations, date: startOfDay, index: (day + affirmationOffset) % affirmations.count)
            entries.append(entry)
        }

        completion(Timeline(entries: entries, policy: .atEnd))
    }
}

struct AffirmationWidgetEntryView : View {
    var entry: AffirmationProvider.Entry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        switch family {
        case .systemSmall:
            AffirmationWidgetView(entry: entry).widgetURL(URL(string: "widgety://affirmations"))
        case .systemMedium:
            AffirmationWidgetView(entry: entry).widgetURL(URL(string: "widgety://affirmations"))
        default:
            Text("Unsupported")
        }
    }
}

struct AffirmationWidget: Widget {
    let kind: String = "AffirmationWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: AffirmationProvider()) { entry in
                AffirmationWidgetEntryView(entry: entry)
                    .containerBackground( for: .widget) {
                        ContainerRelativeShape().fill(Theme.bgColor(theme:entry.currentAffirmation().color)) }
            }
            .configurationDisplayName("Daily affirmation")
            .description("Get a daily dose of positive vibes")
            .supportedFamilies([.systemSmall, .systemMedium])
            .contentMarginsDisabled()
    }
}

//#Preview(as: .systemMedium) {
//    AffirmationWidget()
//} timeline: {
//    AffirmationEntry(phrase: "You are a queen", date: .now, color: ThemeColor.red)
//}

