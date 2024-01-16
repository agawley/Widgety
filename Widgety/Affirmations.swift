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
}

struct AffirmationEntry: TimelineEntry {
    let affirmations: [Affirmation]
    let date: Date
    let index: Int
    
    func currentAffirmation() -> Affirmation {
        affirmations[index]
    }
    
    func nextAffirmation() -> Affirmation {
        affirmations[(index + 1) % affirmations.count]
    }
}

@Observable
class Affirmations {
    
    static var defaults = Affirmations()
    static let defaultAffirmations = [
        Affirmation(id: UUID(), phrase: "You are a queen 👑", color: .blue),
        Affirmation(id: UUID(), phrase: "Go out there and smash it 🚀", color: .red),
        Affirmation(id: UUID(), phrase: "I believe in you 👊", color: .orange),
        Affirmation(id: UUID(), phrase: "You got this 💪", color: .green),
        Affirmation(id: UUID(), phrase: "Whatever happens you are a star 🌟", color: .purple),
        Affirmation(id: UUID(), phrase: "You look fabulous 💇‍♂️", color: .black)
    ]

    private var timer = Timer()
    private let key = "gawley.affirmations"
    
    var items: [Affirmation] = []
    
    
    func saveItems() {
        print("Save affirmations")
        if let encoded = try? JSONEncoder().encode(self.items) {
            UserDefaults(suiteName: "group.org.gawley.widgety")!.set(encoded, forKey: self.key)
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

