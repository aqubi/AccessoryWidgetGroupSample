//
//  WidgetGroupApp.swift
//  WidgetGroup Watch App
//
//  Created by Hideko Ogawa on 2024/09/30.
//

import SwiftUI

@main
struct WidgetGroup_Watch_AppApp: App {
    var model = MyDataModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView(model: model)
                    .navigationTitle("Widget Group")
                    .navigationBarTitleDisplayMode(.inline)
                    .onOpenURL { url in
                        model.url = url
                    }
                    .onContinueUserActivity("MyWatchWidget") { activity in
                        model.userActivity = activity
                    }
                    .onReceive(NotificationCenter.default.publisher(for: .performAppIntent)) { notification in
                        model.intent = notification.object as? MyAppIntent
                    }
            }
        }
    }
}

@Observable @MainActor class MyDataModel {
    var intent: MyAppIntent?
    var url: URL?
    var userActivity: NSUserActivity?
}

