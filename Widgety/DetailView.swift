//
//  DetailView.swift
//  Widgety
//
//  Created by Alex Gawley on 06/11/2023.
//

import SwiftUI


struct DetailView: View {
    @Binding var event: Event
    var body: some View {
        List {
            TextField("name", text: $event.name)
            DatePicker(selection: $event.date, displayedComponents: .date) {
                            Text("Date")
                        }
        }
    }
}
