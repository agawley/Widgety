//
//  NextAffirmationIntent.swift
//  Widgety
//
//  Created by Alex Gawley on 06/01/2024.
//

import Foundation
import AppIntents

struct NextAffirmationIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Move to the next affirmation"
    static var description = IntentDescription("Show the next affirmation in the widget")
    static let offsetKey = "AffirmationOffset"
    
    func perform() async throws -> some IntentResult {
        let fidgetOffset = UserDefaults(suiteName: "group.org.gawley.widgety")!.integer(forKey: NextAffirmationIntent.offsetKey)
        
        UserDefaults(suiteName: "group.org.gawley.widgety")!.set(fidgetOffset + 1, forKey: NextAffirmationIntent.offsetKey)
        UserDefaults(suiteName: "group.org.gawley.widgety")!.synchronize()
        return .result()
    }
}
