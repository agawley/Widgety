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
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Event"
    static var defaultQuery = EventQuery()
            
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(name)")
    }
    
    static func allEvents() -> [Event] {
        let events = Events()
        return events.items
    }
    
    func timelineEntry(entryDate: Date) -> EventEntry {
        return EventEntry(name: name, date: entryDate)
    }
}

struct EventQuery: EntityQuery {
    func entities(for identifiers: [Event.ID]) async throws -> [Event] {
        let e = Event.allEvents()
        print(e)
        print(identifiers)
        return e.filter { identifiers.contains($0.id) }
    }
    
    func suggestedEntities() async throws -> [Event] {
        Event.allEvents()
    }
    
    func defaultResult() async -> Event? {
        try? await suggestedEntities().last
    }

}

struct EventEntry: TimelineEntry {
    let name: String
    let date: Date
}

@Observable
class Events {
    
    static var shared = Events()

    private var timer = Timer()
    private let key = "gawley.events"
    private let sharedStorageID = "group.org.gawley.widgety"
    
    var items = [Event]() {
        didSet {
            timer.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { _ in
                if let encoded = try? JSONEncoder().encode(self.items) {
                    UserDefaults(suiteName: self.sharedStorageID)!.set(encoded, forKey: self.key)
                }
            })
        }
        
    }
    
    init() {
        if let savedItems = UserDefaults(suiteName: self.sharedStorageID)!.data(forKey: self.key) {
            if let decodedItems = try? JSONDecoder().decode([Event].self, from: savedItems) {
                items = decodedItems
            }
        } else {
            items = [Event(id: UUID(), name: "Default entry")]
        }
    }
}
