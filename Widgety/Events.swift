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
