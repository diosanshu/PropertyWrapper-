//
//  MyIBDWidgetLiveActivity.swift
//  MyIBDWidget
//
//  Created by Haadhya on 29/12/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct MyIBDWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct MyIBDWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MyIBDWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension MyIBDWidgetAttributes {
    fileprivate static var preview: MyIBDWidgetAttributes {
        MyIBDWidgetAttributes(name: "World")
    }
}

extension MyIBDWidgetAttributes.ContentState {
    fileprivate static var smiley: MyIBDWidgetAttributes.ContentState {
        MyIBDWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: MyIBDWidgetAttributes.ContentState {
         MyIBDWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: MyIBDWidgetAttributes.preview) {
   MyIBDWidgetLiveActivity()
} contentStates: {
    MyIBDWidgetAttributes.ContentState.smiley
    MyIBDWidgetAttributes.ContentState.starEyes
}
