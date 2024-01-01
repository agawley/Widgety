//
//  Fidgets.swift
//  Widgety
//
//  Created by Alex Gawley on 29/12/2023.
//

import Foundation
import WidgetKit

struct Fidgets {
    let items = ["circle","checkmark.circle.fill", "clock.arrow.circlepath"]
}

struct FidgetyEntry: TimelineEntry {
    let items = Fidgets().items
    let date: Date
    var index: Int
}
