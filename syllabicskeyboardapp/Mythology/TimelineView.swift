import SwiftUI

struct TimelineView: View {
    @ObservedObject var data = TimelineData()

    var body: some View {
        List(data.events) { event in
            VStack(alignment: .leading, spacing: 4) {
                Text(event.year)
                    .font(.headline)
                Text(event.title)
                    .font(.subheadline)
                Text(event.description)
                    .font(.body)
            }
            .padding(.vertical, 4)
        }
        .navigationTitle("Mythology Timeline")
    }
}
