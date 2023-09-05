//
//  NotesWidgets.swift
//  NotesWidgets
//
//  Created by Philip Abakah on 21/07/2023.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        // let addNote = userDefaults?.string(forKey: "addNoteWidget") ?? "No screenshot available"
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
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

struct NotesWidgetsEntryView : View {
    var entry: Provider.Entry
    let data = UserDefaults.init(suiteName:"group.slightlynotie")
    let iconPath: String?

    init(entry: Provider.Entry) {
        self.entry = entry
        iconPath = data?.string(forKey: "plus")
    }
    var body: some View {
        VStack {
            Image(systemName: "plus")
                .font(.system(size: 60)).background(Color.black).foregroundColor(Color.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black) 
    }
    // var body: some View {
    //      Image(uiImage: UIImage(contentsOfFile: iconPath!)!).resizable()
    //                 .scaledToFill()
    //                 .frame(width: 64, height: 64).background(Color.red) 
    // }
}

struct NotesWidgets: Widget {
    let kind: String = "NotesWidgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            NotesWidgetsEntryView(entry: entry).background(Color.blue) 
        }
        .configurationDisplayName("Add Note")
        .description("Add notes easily from the home screen.")
    }
}

struct NotesWidgets_Previews: PreviewProvider {
    static var previews: some View {
        NotesWidgetsEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
