//
//  NextCountdownIntent.swift
//  WidgetyWidgetExtension
//
//  Created by Alex Gawley on 02/01/2024.
//

import Foundation
import AppIntents

struct NextCountdownIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Move to the next countdown"
    static var description = IntentDescription("Show the next countdown in the widget")
    static let offsetKey = "CountdownOffset"
    
    func perform() async throws -> some IntentResult {
        let fidgetOffset = UserDefaults(suiteName: "group.org.gawley.widgety")!.integer(forKey: NextCountdownIntent.offsetKey)
        
        UserDefaults(suiteName: "group.org.gawley.widgety")!.set(fidgetOffset + 1, forKey: NextCountdownIntent.offsetKey)
        UserDefaults(suiteName: "group.org.gawley.widgety")!.synchronize()
        return .result()
    }
}
