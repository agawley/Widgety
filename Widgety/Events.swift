//
//  Events.swift
//  Widgety
//
//  Created by Alex Gawley on 06/11/2023.
//

import Foundation
import WidgetKit
import AppIntents

struct EventEntry: TimelineEntry {
    let name: String
    let daysUntil: Int
    let date: Date
    let color: ThemeColor
}

struct Event: Identifiable, Hashable, Codable, AppEntity {
    let id: UUID
    var name: String
    var date: Date
    var color: ThemeColor
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Event"
    static var defaultQuery = EventQuery()
            
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(name)")
    }
    
    static func allEvents() -> [Event] {
        let events = Events().items
        return events
    }
    
    private func daysUntil(fromDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: calendar.startOfDay(for: fromDate), to: calendar.startOfDay(for: date))
        return components.day!
    }
    
    func timelineEntry(entryDate: Date) -> EventEntry {
        return EventEntry(name: name, daysUntil: daysUntil(fromDate: entryDate), date: entryDate,  color: color)
    }
}

struct EventQuery: EntityQuery {
    func entities(for identifiers: [Event.ID]) async throws -> [Event] {
        return Event.allEvents().filter { identifiers.contains($0.id) }
    }
    
    func suggestedEntities() async throws -> [Event] {
        return Event.allEvents()
    }
    
    func defaultResult() async -> Event? {
        return try? await suggestedEntities().first
    }
}

@Observable
class Events {
    private var timer = Timer()
    
    
    var items = [Event]() {
        didSet {
            timer.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { _ in
                print("setA")
                if let encoded = try? JSONEncoder().encode(self.items) {
                    UserDefaults(suiteName: "group.org.gawley.widgety")!.set(encoded, forKey: "Events")
                }
            })
        }
        
    }
    
    init() {
        if let savedItems = UserDefaults(suiteName: "group.org.gawley.widgety")!.data(forKey: "Events") {
            if let decodedItems = try? JSONDecoder().decode([Event].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}
