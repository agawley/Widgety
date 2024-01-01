//
//  FidgetyWidget.swift
//  Widgety
//
//  Created by Alex Gawley on 29/12/2023.
//

import SwiftUI

import WidgetKit
import SwiftUI

struct FidgetyProvider: TimelineProvider {
    
    func placeholder(in context: Context) -> FidgetyEntry {
        FidgetyEntry(date: .now, index: 0)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (FidgetyEntry) -> Void) {
        completion(FidgetyEntry(date: .now, index: 0))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<FidgetyEntry>) -> Void) {
        var entries: [FidgetyEntry] = []
        let calendar = Calendar.current
        
        let fidgetOffset = UserDefaults(suiteName: "group.org.gawley.widgety")!.integer(forKey: "FidgetOffset")
        

//        UserDefaults.standard.set(deletedMailsCount, forKey: "NumberofMailsDeleted")
//        UserDefaults.standard.synchronize()
        
        // Generate a timeline consisting of seven entries a day apart, starting from the current date.
        let currentDate = Date()
        for dayOffset in 0 ..< 3 {
            let entryDate = calendar.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startOfDay = calendar.startOfDay(for: entryDate)
            let entry = FidgetyEntry(date: startOfDay, index: (dayOffset + fidgetOffset) % 3)
            entries.append(entry)
        }

        completion(Timeline(entries: entries, policy: .atEnd))
    }
}

struct FidgetyWidgetEntryView : View {
    var entry: FidgetyProvider.Entry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        switch family {
        case .systemSmall:
            FidgetyWidgetView(entry: entry).widgetURL(URL(string: "widgety://affirmations"))
        case .systemMedium:
            FidgetyWidgetView(entry: entry).widgetURL(URL(string: "widgety://affirmations"))
        default:
            Text("Unsupported")
        }
    }
}

struct FidgetyWidget: Widget {
    let kind: String = "FidgetyWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: FidgetyProvider()) { entry in
                FidgetyWidgetEntryView(entry: entry)
            }
            .configurationDisplayName("Fidget widget")
            .description("Tap to get a new treat")
            .supportedFamilies([.systemSmall, .systemMedium])
            .contentMarginsDisabled()
    }
}

#Preview(as: .systemMedium) {
    FidgetyWidget()
} timeline: {
    AffirmationEntry(phrase: "You are a queen", date: .now, color: ThemeColor.red)
}

