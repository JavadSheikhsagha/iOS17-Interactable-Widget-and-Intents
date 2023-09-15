//
//  Widgy.swift
//  Widgy
//
//  Created by Javad on 9/15/23.
//

import WidgetKit
import SwiftUI
import AppIntents

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct WidgyEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack(alignment: .bottom) {
            NetworkImage(url: URL(string: UserDefaults(suiteName: "group.com.example.widgy")?.string(forKey: "image") ?? ""))
            
            Button(intent: UpdateImageIntent()) {
                Text("Update Image")
            }
            
        }
    }
}

struct UpdateImageIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Update Image Intent"
    
    
    func perform() async throws -> some IntentResult {
        if let store = UserDefaults(suiteName: "group.com.example.widgy") {
            
            store.setValue(imageList.randomElement(), forKey: "image")
            
            return .result()
        }
        return .result()
    }
}


struct Widgy: Widget {
    let kind: String = "Widgy"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                WidgyEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                WidgyEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    Widgy()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}

