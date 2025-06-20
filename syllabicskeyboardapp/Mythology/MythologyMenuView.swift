import SwiftUI

struct MythologyMenuView: View {
    var body: some View {
        VStack(spacing: 20) {
            NavigationLink("Search Mythology") {
                MythologyView()
            }
            .buttonStyle(.borderedProminent)

            NavigationLink("Mythology Timeline") {
                TimelineView()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Explore Mythology")
    }
}
