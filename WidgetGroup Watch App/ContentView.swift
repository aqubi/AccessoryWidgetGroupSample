//
//  ContentView.swift
//  WidgetGroup Watch App
//
//  Created by Hideko Ogawa on 2024/09/30.
//

import SwiftUI

struct ContentView: View {
    var model: MyDataModel

    var body: some View {
        ScrollView {
            VStack (spacing: 5) {
                ContentRowLabel(title: "Intent via Notification", value: model.intent?.id, imageName: model.intent?.imageName)

                ContentRowLabel(title: "WidgetURL", value: model.url?.absoluteString, imageName: nil)

                ContentRowLabel(title: "UserActivity", value: model.userActivity?.activityType, imageName: nil)

                Button {
                    model.intent = nil
                    model.url = nil
                    model.userActivity = nil
                } label: {
                    Text("Clear")
                }
            }
        }
    }
}

private struct ContentRowLabel: View {
    let title: String
    let value: String?
    let imageName: String?

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            HStack {
                if let imageName {
                    Image(systemName: imageName)
                }
                Text(value ?? "nil")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .listRowBackground(Color.clear)
    }
}

#Preview {
    ContentView(model: MyDataModel())
}
