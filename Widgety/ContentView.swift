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
    @State var events = Events.shared
        
    var body: some View {
        NavigationView{
                List{
                    Section{
                        ForEach($events.items) {$event in
                            NavigationLink(destination: DetailView(event: $event)) {
                                HStack {
                                    Text(event.name)
                                    
                                }
                            }
                        }.onDelete { index in
                            events.items.remove(atOffsets: index)
                        }
                    }
                    Button {
                        withAnimation {
                            events.items.append(Event(id:UUID(), name: "My new event"))
                        }
                    } label: {
                        Label("Add", systemImage: "plus")
                    }
                }.navigationBarTitle("Countdowns")
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
