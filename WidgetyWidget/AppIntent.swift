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
    static var description = IntentDescription("Selects the event to count towards")

    @Parameter(title: "Event name")
    var event: Event
    
}

