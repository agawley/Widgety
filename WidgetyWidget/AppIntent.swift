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

    @Parameter(title: "Event name")
    var event: Event
    
    init(event:Event) {
        self.event = event
    }
    
    init() {
    }
}

