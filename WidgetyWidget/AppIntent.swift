//
//  AppIntent.swift
//  WidgetyWidget
//
//  Created by Alex Gawley on 05/11/2023.
//

import WidgetKit
import AppIntents



struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Countdown"
    static var description = IntentDescription("Countdown toward a future event")

    @Parameter(title: "Event name")
    var event: Event
    
    init(event:Event) {
        self.event = event
    }
    
    init() {
    }
}

