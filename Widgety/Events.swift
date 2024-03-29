//
//  Events.swift
//  Widgety
//
//  Created by Alex Gawley on 06/11/2023.
//

import Foundation
import WidgetKit
import AppIntents

struct Event: Identifiable, Hashable, Codable, AppEntity {
    let id: UUID
    var name: String
    var date: Date
    var color: ThemeColor
    var repeating: RepeatOptions = .never
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Event"
    static var defaultQuery = EventQuery()
            
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(name)")
    }
    
    static func allEvents() -> [Event] {
        let events = Events()
        return events.items
    }
    
    private func daysUntil(fromDate: Date) -> Int {
        let calendar = Calendar.current
        let fromDate = calendar.startOfDay(for: fromDate)
        let fromDateMinusOne = calendar.date(byAdding: .day, value: -1, to: fromDate)!
        var toDate = calendar.startOfDay(for: date)
        if (toDate < fromDate) {
            switch repeating {
            case .weekly:
                toDate = calendar.nextDate(after: fromDateMinusOne, matching: calendar.dateComponents([.weekday], from: toDate), matchingPolicy: .nextTime)!
            case .monthly:
                toDate = calendar.nextDate(after: fromDateMinusOne, matching: calendar.dateComponents([.day], from: toDate), matchingPolicy: .nextTime)!
            case .yearly:
                toDate = calendar.nextDate(after: fromDateMinusOne, matching: calendar.dateComponents([.day, .month], from: toDate), matchingPolicy: .nextTime)!
            case .never:
                break
            }
        }
        if toDate == fromDate {
                return 0;
        } else {
            return calendar.dateComponents([.day], from: fromDate, to: toDate).day!
        }
    }
    
    func timelineEntry(entryDate: Date) -> EventEntry {
        let formatter = DateFormatter()
        formatter.dateFormat = "dM"
        let tag = (formatter.string(from: date)) == "2512" ? Tags.xmas : nil;
        return EventEntry(id: id, name: name, daysUntil: daysUntil(fromDate: entryDate), date: entryDate,  color: color, tag: tag)
    }
}

struct EventQuery: EntityQuery {
    func entities(for identifiers: [Event.ID]) async throws -> [Event] {
        let e = Event.allEvents()
        return e.filter { identifiers.contains($0.id) }
    }
    
    func suggestedEntities() async throws -> [Event] {
        Event.allEvents()
    }
    
    func defaultResult() async -> Event? {
        try? await suggestedEntities().first
    }
}

enum RepeatOptions: String, CaseIterable, Identifiable, Codable, Hashable {
    case never, weekly, monthly, yearly
    var id: Self { self }
}

struct WeeksDaysHours {
    let weeks: Int
    let days: Int
    let hours: Int
}

enum Tags: String, CaseIterable, Identifiable, Codable, Hashable {
    case xmas
    var id: Self { self }
}

struct EventEntry: TimelineEntry {
    static let NO_OPTION_NAME = "xyx_NO_OPTION_SET_xyx"
    let id: UUID
    let name: String
    let daysUntil: Int
    let date: Date
    let color: ThemeColor
    var tag: Tags?
}

@Observable
class Events {
    
    private static var defaults = {
        Events()
    }()
    
    static func getDefault() -> Events {
        defaults
    }

    private var timer = Timer()
    private let key = "gawley.events"
    
    var items: [Event] = []
    
    func saveItems() {
        print("Save events")
        if let encoded = try? JSONEncoder().encode(self.items) {
            UserDefaults(suiteName: "group.org.gawley.widgety")!.set(encoded, forKey: self.key)
        }
    }
    
    init() {
        if let savedItems = UserDefaults(suiteName: "group.org.gawley.widgety")!.data(forKey: self.key) {
            if let decodedItems = try? JSONDecoder().decode([Event].self, from: savedItems) {
                items = decodedItems
            }
        }
    }
}
