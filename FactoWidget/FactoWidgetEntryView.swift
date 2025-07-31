import WidgetKit
import SwiftUI

struct FactoWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.text)
            .font(.custom("AmericanTypewriter", size: 18))
            .foregroundStyle(Color.white)
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
    }
}
