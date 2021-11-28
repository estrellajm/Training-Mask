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
                exercise: exercise_1,
                title: exercise_1.title,
                image: exercise_1.image,
                inhale: exercise_1.inhale,
                hold: exercise_1.hold,
                exhale: exercise_1.exhale,
                bps: exercise_1.breaths_per_set,
                sets: exercise_1.sets,
                bpsTime: (exercise_1.inhale + exercise_1.hold + exercise_1.exhale),
                setTime: ((exercise_1.inhale + exercise_1.hold + exercise_1.exhale) * exercise_1.breaths_per_set),
                exerciseTime: (((exercise_1.inhale + exercise_1.hold + exercise_1.exhale) * exercise_1.breaths_per_set) * exercise_1.sets),
                workoutTime: (((exercise_1.inhale + exercise_1.hold + exercise_1.exhale) * exercise_1.breaths_per_set) * exercise_1.sets * 4)
            )
        }
    }
}
