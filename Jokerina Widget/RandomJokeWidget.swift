//
//  RandomJokeWidget.swift
//  Jokerina Widget
//
//  Created by Marina De Pazzi on 24/08/21.
//

import WidgetKit
import SwiftUI

struct RandomJokeWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> RandomJokeEntry {
        RandomJokeEntry(date: Date(), joke: JokeProvider.random())
    }

    func getSnapshot(in context: Context, completion: @escaping (RandomJokeEntry) -> ()) {
        let entry = RandomJokeEntry(date: Date(), joke: JokeProvider.random())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [RandomJokeEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = RandomJokeEntry(date: entryDate, joke: JokeProvider.random())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct RandomJokeEntry: TimelineEntry {
    let date: Date
    let joke: Joke
}

struct PlaceholderView : View {
  var body: some View {
    Text("Placeholder View")
  }
}

struct RandomJokeWidgetEntryView : View {
    var entry: RandomJokeWidgetProvider.Entry

    var body: some View {
        JokeWidgetView(joke: entry.joke)
    }
}

struct RandomJokeWidget: Widget {
    let kind: String = "RandomJokeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: RandomJokeWidgetProvider()
        ) { entry in
            RandomJokeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Random Jokes")
        .description("Display a widget with a joke that is updated randomly.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct Jokerina_Widget_Previews: PreviewProvider {
    static var previews: some View {
        RandomJokeWidgetEntryView(entry: RandomJokeEntry(date: Date(), joke: JokeProvider.random()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
