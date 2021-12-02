//
//  CountdownApp.swift
//  Shared
//
//  Created by Jose Estrella on 11/23/21.
//

import SwiftUI

@main
struct CountdownApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
            CountdownView(
                exercise: basicExercises[0]
            )
        }
    }
}
