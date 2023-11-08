//
//  SmallWidgetView.swift
//  Widgety
//
//  Created by Alex Gawley on 08/11/2023.
//

import SwiftUI

struct SmallWidgetView: View {
    var entry: EventEntry
    
    var body: some View {
        if entry.daysUntil == 0 {
            Text(entry.name).font(.system(.title3, design: .rounded)).foregroundColor(Theme.textColor(theme:entry.color)).fontWeight(.bold)
                .multilineTextAlignment(.center).minimumScaleFactor(0.6).padding([.bottom], 10)
            Text("is TODAY!").font(.system(.title2, design: .rounded)).foregroundColor(Theme.textColor(theme:entry.color)).fontWeight(.bold)
                .minimumScaleFactor(0.6)
        } else if entry.daysUntil < 0 {
            VStack {
                Text((-entry.daysUntil).formatted()).font(.system(size:60, weight:.heavy, design: .rounded)).foregroundColor(Theme.textColor(theme:entry.color))
                    .minimumScaleFactor(0.6)
                Text(entry.daysUntil == -1 ? "day since" : "days since").foregroundColor(Theme.textColor(theme:entry.color))
                Spacer()
                Text(entry.name.lowercased()).font(.system(.title3, design: .rounded)).foregroundColor(Theme.textColor(theme:entry.color)).fontWeight(.bold)
                    .multilineTextAlignment(.center).minimumScaleFactor(0.6)
            }
        } else {
            VStack {
                Text(entry.daysUntil.formatted()).font(.system(size:60, weight:.heavy, design: .rounded)).foregroundColor(Theme.textColor(theme:entry.color))
                    .minimumScaleFactor(0.6)
                Text(entry.daysUntil == 1 ? "day until" : "days until" ).foregroundColor(Theme.textColor(theme:entry.color))
                Spacer()
                Text(entry.name.lowercased()).font(.system(.title3, design: .rounded)).foregroundColor(Theme.textColor(theme:entry.color)).fontWeight(.bold)
                    .multilineTextAlignment(.center).minimumScaleFactor(0.6)
            }
        }
    }
}

#Preview {
    SmallWidgetView(entry: EventEntry(name: "end of the world", daysUntil: 1201, date: .now, color: ThemeColor.red))
}
