//
//  Theme.swift
//  Widgety
//
//  Created by Alex Gawley on 07/11/2023.
//

import Foundation
import SwiftUI

enum ThemeColor: String, CaseIterable, Identifiable, Codable, Hashable {
    case blue, red, green, black, orange, purple, grey
    var id: Self { self }
}

struct Theme {
    static private let bgColors: [ThemeColor: AnyGradient] = [.blue:  Color.blue.gradient, .red:  Color.red.gradient, .green: Color.green.gradient, .black:  Color.black.gradient,  .orange: Color.orange.gradient, .purple:  Color.indigo.gradient, .grey: Color.gray.gradient]

    static private let textColors: [ThemeColor: Color] = [.blue: Color.white, .red: Color.white, .green:  Color.black, .black: Color.white, .orange:  Color.black, .purple:  Color.white, .grey: Color.white]
    
    static func bgColor(theme: ThemeColor) -> AnyGradient { return bgColors[theme, default: Color.blue.gradient]}
    static func textColor(theme: ThemeColor) -> Color { return textColors[theme, default: Color.white]}
}
