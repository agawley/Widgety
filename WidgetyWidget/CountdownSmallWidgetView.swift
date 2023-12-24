//
//  SmallWidgetView.swift
//  Widgety
//
//  Created by Alex Gawley on 08/11/2023.
//

import SwiftUI

struct CountdownSmallWidgetView: View {
    var entry: EventEntry?
    
    var body: some View {
        let formatter = DateFormatter()
        formatter.dateFormat = "dM"
        
        return ZStack {
            if let event = entry {
                ZStack {
                    if (formatter.string(from: Date.now.addingTimeInterval(TimeInterval(event.daysUntil * 24 * 60 * 60)))  == "2512") {
                        Image("tree")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .mask(Image("tree"))
                            .colorInvert()
                            .opacity(0.3)
                            .padding(13)
                    }
                    if (event.name == EventEntry.NO_OPTION_NAME) {
                        Text("Tap to add an event or tap and hold to configuire")
                            .font(.system(size:20, weight:.heavy, design: .rounded))
                            .foregroundColor(Theme.textColor(theme:event.color))
                            .multilineTextAlignment(.center)
                            .padding([.horizontal], 10)
                    } else if event
                        .daysUntil == 0 {
                        VStack {
                            Text(event.name).font(.system(.title3, design: .rounded)).foregroundColor(Theme.textColor(theme:event.color)).fontWeight(.bold)
                                .multilineTextAlignment(.center).minimumScaleFactor(0.6).padding([.bottom], 10)
                            Text("is TODAY!").font(.system(.title2, design: .rounded)).foregroundColor(Theme.textColor(theme:event.color)).fontWeight(.bold)
                                .minimumScaleFactor(0.6)
                        }
                    } else {
                        VStack(spacing:0) {
                            Text(abs(event.daysUntil).formatted())
                                .font(.system(size:abs(event.daysUntil) > 999 ? 45 : 55, weight:.heavy,design: .rounded))
                                .foregroundColor(Theme.textColor(theme:event.color))
                                .layoutPriority(2)
                                .lineLimit(1)
                                .frame(height: 50, alignment: .center)
                            
                            HStack(alignment: .center) {
                                Text(event.daysUntil < 0 ? (event.daysUntil == -1 ? "day since" : "days since") : event.daysUntil == 1 ? "day until" : "days until" )
                                    .foregroundColor(Theme.textColor(theme:event.color))
                                    .frame(maxHeight: .infinity, alignment: .center)
                                    .padding(.top, 5)
                            }
                            Text(event.name)
                                .font(.system(size:28, weight:.heavy, design: .rounded))
                                .foregroundColor(Theme.textColor(theme:event.color))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.4)
                                .frame(height: 50, alignment: .center)
                                .layoutPriority(1)
                        }.padding(20)
                    }
                }
            } else {
                Text("Open the app to create an event")
            }
            
        }
    }
}

#Preview {
    HStack{
        CountdownSmallWidgetView(entry: EventEntry(name: "end of term - yay!", daysUntil: 1200, date: .now, color: ThemeColor.red))
    }.frame(width: 175, height: 175).background(.red).cornerRadius(25)
}
