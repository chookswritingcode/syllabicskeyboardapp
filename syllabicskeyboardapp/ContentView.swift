//
//  ContentView.swift
//  syllabicskeyboardapp
// 
//  Created by Carter Davidson on 4/2/25.
//

import SwiftUI
import SwiftData
import Foundation
//App Homepage
struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink("Syllabic Sound Table") {
                    SyllabicsGridView()
                }
                .buttonStyle(.borderedProminent)

                NavigationLink("Keyboard Setup Instructions") {
                    KeyboardInstructionsView()
                }
                .buttonStyle(.borderedProminent)

                NavigationLink("Language Resources") {
                    ResourcesView()
                }
                .buttonStyle(.borderedProminent)
             
                NavigationLink("Syllabic Composer") {
                    SyllabicComposerView()
                }
                .buttonStyle(.borderedProminent)

               /* NavigationLink(destination: MiniGameView()) {
                    Label("Pathwalker Mini-Game", systemImage: "leaf.fill")
                        .font(.headline)
                        .padding()
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(8)
                } */
                NavigationLink(destination: ScottPottCalendarView()) {
                    Label("Open Lunasolar Calendar", systemImage: "calendar")
                        .font(.headline)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                }
                
                NavigationLink(destination: MythologyMenuView()) {
                    Label("Explore Mythology", systemImage: "book.closed")
                        .font(.headline)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }

            }
            .padding()
            .navigationTitle("Bodewadmiiwiibiian")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
