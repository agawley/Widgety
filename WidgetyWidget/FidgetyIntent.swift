//
//  FidgetyIntent.swift
//  WidgetyWidgetExtension
//
//  Created by Alex Gawley on 31/12/2023.
//

import Foundation
import AppIntents

struct FidgetyIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Emoji Ranger SuperCharger"
    static var description = IntentDescription("All heroes get instant 100% health.")
    
    func perform() async throws -> some IntentResult {
        let fidgetOffset = UserDefaults(suiteName: "group.org.gawley.widgety")!.integer(forKey: "FidgetOffset")
        

        UserDefaults(suiteName: "group.org.gawley.widgety")!.set(fidgetOffset + 1, forKey: "FidgetOffset")
        UserDefaults(suiteName: "group.org.gawley.widgety")!.synchronize()
        return .result()
    }
}
