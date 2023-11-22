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
        VStack {
            Text(entry.name).font(.system(.title3, design: .rounded))
                .multilineTextAlignment(.center).minimumScaleFactor(0.6)
        }
    }
}

#Preview {
    HStack{
        SmallWidgetView(entry: EventEntry(name: "end of term - yay!", date: .now))
    }.frame(width: 175, height: 175).background(.red).cornerRadius(25)
}
