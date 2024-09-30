//
//  MyWidget.swift
//  MyWidget
//
//  Created by Hideko Ogawa on 2024/09/30.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct MyWatchWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        AccessoryWidgetGroup("Widget Group") {
            MyWatchWidgetEntryButton(intent: .init(id: "001", imageName: "star.fill"))
            MyWatchWidgetEntryButton(intent: .init(id: "002", imageName: "heart.fill"))
            MyWatchWidgetEntryButton(intent: .init(id: "003", imageName: "leaf.fill"))
        }
    }
}

//Button View
private struct MyWatchWidgetEntryButton: View {
    @Environment(\.showsWidgetContainerBackground) var showsWidgetContainerBackground
    let intent: MyAppIntent

    var body: some View {
        Button(intent: intent) {
            ZStack {
                if showsWidgetContainerBackground {
                    Color.black
                } else {
                    AccessoryWidgetBackground()
                }
                VStack {
                    Image(systemName: intent.imageName)
                        .font(.headline)
                    Text(intent.id)
                        .font(.system(size: 10, weight: .bold))
                }
            }
        }
        .buttonStyle(.plain)
        .widgetURL(URL(string: "widget://" + intent.id))
    }
}

@main
struct MyWatchWidget: Widget {
    let kind: String = "MyWatchWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MyWatchWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}


#Preview(as: .accessoryRectangular) {
    MyWatchWidget()
} timeline: {
    SimpleEntry(date: .now)
}
