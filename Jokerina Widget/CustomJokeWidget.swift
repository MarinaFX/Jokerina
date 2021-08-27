//
//  CustomJokeWidget.swift
//  Jokerina
//
//  Created by Marina De Pazzi on 25/08/21.
//

import SwiftUI
import WidgetKit

struct CustomJokeWidgetProvider: IntentTimelineProvider {
    typealias Entry = CustomJokeEntry
    typealias Intent = SelectJokeIntent
    
    func placeholder(in context: Context) -> CustomJokeEntry {
        CustomJokeEntry(date: Date(), joke: JokeProvider.random())
    }
    
    func getSnapshot(for configuration: SelectJokeIntent, in context: Context, completion: @escaping (CustomJokeEntry) -> Void) {
        // Use a random joke in the widget gallery.
        if context.isPreview {
            completion(CustomJokeEntry(date: Date(), joke: JokeProvider.random()))
            return
        }
        
        let joke = lookupJokeDetails(for: configuration)
        let entry = CustomJokeEntry(date: Date(), joke: joke)
        completion(entry)
    }
    
    func getTimeline(for configuration: SelectJokeIntent, in context: Context, completion: @escaping (Timeline<CustomJokeEntry>) -> Void) {
        var entries = [CustomJokeEntry]()
        let joke = lookupJokeDetails(for: configuration)
        let entry = CustomJokeEntry(date: Date(), joke: joke)
        entries.append(entry)
        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
    
    private func lookupJokeDetails(for configuration: SelectJokeIntent) -> Joke {
        guard let jokeID = configuration.joke?.identifier,
              let jokeForConfig = JokeProvider.all().first(where: { joke in
                String(joke.id) == jokeID
              })
        else {
            return JokeProvider.random()
        }
        return jokeForConfig
    }
}

struct CustomJokeEntry: TimelineEntry {
    public let date: Date
    public let joke: Joke
}

struct CustomJokeWidgetEntryView : View {
    var entry: CustomJokeWidgetProvider.Entry
    
    var body: some View {
        JokeWidgetView(joke: entry.joke)
    }
}

struct CustomJokeWidget: Widget {
    private let kind: String = "CustomJokeWidget"
    
    public var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind,
            intent: SelectJokeIntent.self,
            provider: CustomJokeWidgetProvider()
        ) { entry in
            CustomJokeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Custom Joke Widget")
        .description("Display a widget with a joke of your choice.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
