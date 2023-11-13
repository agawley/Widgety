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
            VStack {
                Text(entry.name).font(.system(.title3, design: .rounded)).foregroundColor(Theme.textColor(theme:entry.color)).fontWeight(.bold)
                    .multilineTextAlignment(.center).minimumScaleFactor(0.6).padding([.bottom], 10)
                Text("is TODAY!").font(.system(.title2, design: .rounded)).foregroundColor(Theme.textColor(theme:entry.color)).fontWeight(.bold)
                    .minimumScaleFactor(0.6)
            }
        } else {
            VStack(spacing:0) {
                Text(abs(entry.daysUntil).formatted())
                    .font(.system(size:abs(entry.daysUntil) > 999 ? 45 : 55, weight:.heavy,design: .rounded))
                    .foregroundColor(Theme.textColor(theme:entry.color))
                    .layoutPriority(2)
                    .lineLimit(1)
                    .frame(height: 50, alignment: .center)
                    
                HStack(alignment: .center) {
                    Text(entry.daysUntil < 0 ? (entry.daysUntil == -1 ? "day since" : "days since") : entry.daysUntil == 1 ? "day until" : "days until" )
                        .foregroundColor(Theme.textColor(theme:entry.color))
                        .frame(maxHeight: .infinity, alignment: .center)
                        .padding(.top, 5)
                }
                Text(entry.name.lowercased())
                    .font(.system(size:20, weight:.heavy, design: .rounded))
                    .foregroundColor(Theme.textColor(theme:entry.color))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.6)
                    .frame(height: 50, alignment: .center)
                    .layoutPriority(1)
            }.padding(20)
        }
    }
}

#Preview {
    HStack{
        SmallWidgetView(entry: EventEntry(name: "end of term - yay!", daysUntil: 500, date: .now, color: ThemeColor.red))
    }.frame(width: 175, height: 175).background(.red).cornerRadius(25)
}
