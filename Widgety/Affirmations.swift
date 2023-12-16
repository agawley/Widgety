//
//  Affirmations.swift
//  Widgety
//
//  Created by Alex Gawley on 16/12/2023.
//

import Foundation
import WidgetKit

struct Affirmation: Identifiable, Hashable, Codable {
    let id: UUID
    var phrase: String
    var color: ThemeColor
    
    static func allAffirmations() -> [Affirmation] {
        let affirmations = Affirmations()
        return affirmations.items
    }
    
    func timelineEntry(entryDate: Date) -> AffirmationEntry {
        return AffirmationEntry(phrase: phrase, date: entryDate,  color: color)
    }
}

struct AffirmationEntry: TimelineEntry {
    let phrase: String
    let date: Date
    let color: ThemeColor
}

@Observable
class Affirmations {
    
    static var defaults = Affirmations()
    static let defaultAffirmations = [Affirmation(id: UUID(), phrase: "You are a queen", color: .blue), Affirmation(id: UUID(), phrase: "You look fabulous", color: .red)]

    private var timer = Timer()
    private let key = "gawley.affirmations"
    
    var items = [Affirmation]() {
        didSet {
            timer.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { _ in
                if let encoded = try? JSONEncoder().encode(self.items) {
                    UserDefaults(suiteName: "group.org.gawley.widgety")!.set(encoded, forKey: self.key)
                }
            })
        }
        
    }
    
    init() {
        if let savedItems = UserDefaults(suiteName: "group.org.gawley.widgety")!.data(forKey: self.key) {
            if let decodedItems = try? JSONDecoder().decode([Affirmation].self, from: savedItems) {
                items = decodedItems
            }
        } else {
            items = Affirmations.defaultAffirmations
            if let encoded = try? JSONEncoder().encode(self.items) {
                UserDefaults(suiteName: "group.org.gawley.widgety")!.set(encoded, forKey: self.key)
            }
        }
    }
}

