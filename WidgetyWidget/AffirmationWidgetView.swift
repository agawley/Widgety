//
//  AffirmationWidgetView.swift
//  Widgety
//
//  Created by Alex Gawley on 16/12/2023.
//

import SwiftUI

struct WidgetToggleStyle: ToggleStyle {
    var entry: AffirmationEntry
    
    func makeBody(configuration: Configuration) -> some View {
        let currentAffirmation = entry.affirmations[entry.index]
        let nextAffirmation = entry.affirmations[(entry.index + 1) % entry.affirmations.count]
        configuration.isOn
        ? AffirmationWidgetInnerView(entry: nextAffirmation)
            : AffirmationWidgetInnerView(entry: currentAffirmation)
    }
}

struct AffirmationWidgetView: View {
    var entry: AffirmationEntry
    
    var body: some View {
        ZStack {
            Toggle(isOn: false, intent: NextAffirmationIntent()) {
                Text("Not shown")
            }.toggleStyle(WidgetToggleStyle(entry: entry)).frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct AffirmationWidgetInnerView: View {
    var entry: Affirmation?
    
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
