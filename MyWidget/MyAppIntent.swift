//
//  MyAppIntent.swift
//  WidgetGroup
//
//  Created by Hideko Ogawa on 2024/09/30.
//

import AppIntents

struct MyAppIntent: WidgetConfigurationIntent, Identifiable {
    static var title: LocalizedStringResource = "title"
    static var description = IntentDescription("Sample App Intent")
    static var openAppWhenRun: Bool = true

    @Parameter(title: "id", default: "001")
    var id: String

    @Parameter(title: "imageName", default: "star")
    var imageName: String

    //MARK: - Actions

    func perform() async throws -> some IntentResult {
        await MainActor.run {
            NotificationCenter.default.post(name: .performAppIntent, object: self)
        }
        return .result()
    }

    init(id: String, imageName: String) {
        self.id = id
        self.imageName = imageName
    }

    init() {
        self.id = "001"
        self.imageName = "star"
    }
}

extension Notification.Name {
    static let performAppIntent = NSNotification.Name(rawValue: "firedAppIntent")
}
