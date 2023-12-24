//
//  AffirmationWidgetView.swift
//  Widgety
//
//  Created by Alex Gawley on 16/12/2023.
//

import SwiftUI

struct AffirmationWidgetView: View {
    var entry: AffirmationEntry?
    
    var body: some View {
        
        return ZStack {
            Image("sparkle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .colorInvert()
                .opacity(0.3)
                .padding(8)
            if let event = entry {
                if (event.phrase == EventEntry.NO_OPTION_NAME) {
                    Text("Tap to edit your affirmations")
                        .font(.system(size:20, weight:.heavy, design: .rounded))
                        .foregroundColor(Theme.textColor(theme:event.color))
                        .multilineTextAlignment(.center)
                        .padding([.horizontal], 10)
                } else {
                    VStack(spacing:0) {
                        Text(event.phrase)
                            .font(.system(size:60, weight:.heavy, design: .rounded))
                            .foregroundColor(Theme.textColor(theme:event.color))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.2)
                    }.padding(20)
                }
            } else {
                Text("Open the app to edit your affirmations")
            }
            
        }
    }
}

#Preview {
    HStack{
        CountdownSmallWidgetView(entry: EventEntry(name: "end of term - yay!", daysUntil: 1200, date: .now, color: ThemeColor.red))
    }.frame(width: 175, height: 175).background(.red).cornerRadius(25)
}
