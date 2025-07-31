import WidgetKit
import SwiftUI

struct FactoWidget: Widget {
    let kind: String = "FactoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                FactoWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                FactoWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    FactoWidget()
} timeline: {
    SimpleEntry(date: .now, text: "😀")
    SimpleEntry(date: .now, text: "🤩")
}
