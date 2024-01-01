//
//  SwiftUIView.swift
//  WidgetyWidgetExtension
//
//  Created by Alex Gawley on 29/12/2023.
//

import SwiftUI

struct ImageToggleStyle: ToggleStyle {
    var entry: FidgetyEntry
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn
                  ? entry.items[(entry.index + 1) % 3]
                  : entry.items[entry.index])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
            }
    }
}

struct FidgetyWidgetView: View {
    var entry: FidgetyEntry
    
    var body: some View {
        return VStack{
            Toggle(isOn: false, intent: FidgetyIntent()) {
                Text("hi")
            }.toggleStyle(ImageToggleStyle(entry: entry)).frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        
    }
}

