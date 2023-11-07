//
//  Events.swift
//  Widgety
//
//  Created by Alex Gawley on 06/11/2023.
//

import Foundation


struct Event: Identifiable, Hashable, Codable {
    let id: UUID
    var name: String
    var date: Date
    var color: ThemeColor
    
    static func daysUntilEvent(eventDate: Date, fromDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: calendar.startOfDay(for: fromDate), to: calendar.startOfDay(for: eventDate))
        return components.day!
    }
}

@Observable
class Events {
    var items = [Event]() {
        didSet {
                if let encoded = try? JSONEncoder().encode(items) {
                    UserDefaults(suiteName: "group.org.gawley.widgety")!.set(encoded, forKey: "Events")
                }
            }
        
    }
    
    init() {
        if let savedItems = UserDefaults(suiteName: "group.org.gawley.widgety")!.data(forKey: "Events") {
            if let decodedItems = try? JSONDecoder().decode([Event].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}
