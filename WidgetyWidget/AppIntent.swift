//
//  AppIntent.swift
//  WidgetyWidget
//
//  Created by Alex Gawley on 05/11/2023.
//

import WidgetKit
import AppIntents



struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Select Event"
    static var description = IntentDescription("Select the event to countdown towards.")

    @Parameter(title: "Event name", optionsProvider: EventOptionsProvider())
    var event: Event
    
    init(event:Event) {
        print(event)
        self.event = event
    }
    
    init() {
    }
    
    struct EventOptionsProvider: DynamicOptionsProvider {
        func results() async throws -> [Event] {
            Events().items.compactMap { event in
                return event
            }
        }
        func defaultResult() async -> Event? {
            Events().items.last
        }
    }
}

