import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), text: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        Task {
            let entry = try await createTimelineEntry(date: Date())
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        Task {
            let entries = try await createTimelineEntries(date: Date())
            completion(entries)
        }
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }

    func createTimelineEntry(date: Date) async throws -> SimpleEntry {
        let entry = SimpleEntry(date: date, text: "Sample fact")

        return entry
    }

    func createTimelineEntries(date: Date) async throws -> Timeline<SimpleEntry> {
        let factService = FactService()
        let fact = try await factService.getFact()
        let entry: SimpleEntry = SimpleEntry(date: date, text: fact.text)
        let timeline = Timeline(entries: [entry], policy: .atEnd)

        return timeline
    }
}
