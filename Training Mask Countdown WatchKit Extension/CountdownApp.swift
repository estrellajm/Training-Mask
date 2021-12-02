//
//  CountdownApp.swift
//  Training Mask Countdown WatchKit Extension
//
//  Created by Jose Estrella on 11/28/21.
//

import SwiftUI

@main
struct CountdownApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
