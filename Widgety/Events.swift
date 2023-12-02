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
        return Events().items
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

struct Data {
    static let events = [Event(id: UUID(), name: "An event"), Event(id: UUID(), name: "Another event"), Event(id: UUID(), name: "A third event")]
}

@Observable
class Events {
    
    static var shared = Events()
    

    private var timer = Timer()
    private let key = "gawley.events"
    private let sharedStorageID = "group.org.gawley.widgety"
    
    var items: [Event]
    
    init() {
        items = Data.events
    }
}
