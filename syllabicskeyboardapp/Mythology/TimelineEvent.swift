import Foundation

struct TimelineEvent: Codable, Identifiable {
    let id: String
    let title: String
    let description: String
    let year: String
}

final class TimelineData: ObservableObject {
    @Published var events: [TimelineEvent] = []

    init() {
        load()
    }

    func load() {
        guard let url = Bundle.main.url(
            forResource: "timeline_events",
            withExtension: "json",
            subdirectory: "Mythology"
        ) else {
            print("Timeline JSON file not found")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([TimelineEvent].self, from: data)
            self.events = decoded
        } catch {
            print("Error loading timeline data: \(error)")
        }
    }
}
