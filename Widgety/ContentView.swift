//
//  ContentView.swift
//  Widgety
//
//  Created by Alex Gawley on 05/11/2023.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @State private var events = Events()
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    ForEach($events.items) {$event in
                        NavigationLink(destination: DetailView(event: $event)) {
                            Text(event.name)
                        }
                    }.onDelete { index in
                        events.items.remove(atOffsets: index)
                    }
                }
                Button {
                    withAnimation {
                        events.items.append(Event(id:UUID(), name: "End of school", date: Date()))
                    }
                } label: {
                    Label("Add", systemImage: "plus")
                }
            }
        }.onChange(of: scenePhase) {
            if scenePhase == .background {
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
        
    }
}


#Preview {
    ContentView()
}
