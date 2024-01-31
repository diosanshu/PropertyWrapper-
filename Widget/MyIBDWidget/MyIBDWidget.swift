import SwiftUI
import WidgetKit

struct MyIBDWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "MyIBDWidget", provider: MyIBDWidgetProvider()) { entry in
            MyIBDWidgetView(entry: entry)
        }
        .configurationDisplayName("My IBD Widget")
        .description("Widget to display IBD information")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}
struct MyIBDWidgetView: View {
    var entry: ContentViewModel.Entry

    var body: some View {
        #if DEBUG
        Text("Debugging Info")
        LargeWidgetContentView(entry: entry)

            .onAppear {
                print("Widget Family: \(entry.family)")

            }
        #endif
    }
}


struct MyIBDWidgetView: View {
    var entry: ContentViewModel.Entry

    var body: some View {

        switch entry.family {
        case .systemLarge:
            LargeWidgetContentView(entry: entry)
        default:
            MediumWidgetContentView(entry: entry)
        }
    }
}

struct LargeWidgetContentView: View {
    var entry: ContentViewModel.Entry

    var body: some View {
        VStack {
            Text("Large Widget")
                .font(.title)

            // Additional content specific to the large widget
            Text("Large Widget Content")
                .foregroundColor(.blue)
        }
    }
}

struct MediumWidgetContentView: View {
    var entry: ContentViewModel.Entry

    var body: some View {
        VStack {
            Text("Medium Widget")
                .font(.title)

            // Additional content specific to the medium widget
            Text("Medium Widget Content")
                .foregroundColor(.green)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct MyIBDWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> ContentViewModel.Entry {
        ContentViewModel.Entry(date: Date(), viewModel: ContentViewModel(), family: context.family)
    }

    func getSnapshot(in context: Context, completion: @escaping (ContentViewModel.Entry) -> Void) {
        let entry = ContentViewModel.Entry(date: Date(), viewModel: ContentViewModel(), family: context.family)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<ContentViewModel.Entry>) -> Void) {
        let entry = ContentViewModel.Entry(date: Date(), viewModel: ContentViewModel(), family: context.family)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}


