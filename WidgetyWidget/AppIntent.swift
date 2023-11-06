//
//  AppIntent.swift
//  WidgetyWidget
//
//  Created by Alex Gawley on 05/11/2023.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Select event"
    static var description = IntentDescription("Selects the even to count towards")

    // An example configurable parameter.
    @Parameter(title: "Event name")
    var event: EventDetail
}

struct EventDetail: AppEntity {
    let id: UUID
    let eventName: String
    let date: Date
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Character"
    static var defaultQuery = EventQuery()
            
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(eventName)")
    }
    
    static func myMethod1() -> [EventDetail] {
        let events = Events()
        var eventDetails: [EventDetail] = []
        for event in events.items {
            eventDetails.append(EventDetail(id:event.id, eventName: event.name, date: event.date))
        }
        return eventDetails
    }

}

struct EventQuery: EntityQuery {
    func entities(for identifiers: [EventDetail.ID]) async throws -> [EventDetail] {
        return EventDetail.myMethod1().filter { identifiers.contains($0.id) }
    }
    
    func suggestedEntities() async throws -> [EventDetail] {
        return EventDetail.myMethod1()
    }
    
    func defaultResult() async -> EventDetail? {
        return try? await suggestedEntities().first
    }
}
