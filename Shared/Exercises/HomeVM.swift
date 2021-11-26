//
//  File.swift
//  Training Mask
//
//  Created by Jose Estrella on 9/24/21.
//

import Foundation

class HomeVM: ObservableObject {
    
    // String == Category
    @Published var exercises: [String: [Exercise]] = [:]
    
    public var allCategories: [String] {
        exercises.keys.map({ String($0) })
    }
    
    public func getExercise(forCat cat: String) -> [Exercise] {
        return exercises[cat] ?? []
    }
    
    init() {
        setupExercises()
    }
    
    func setupExercises() {
        exercises["First one baby!"] = basicExercises
    }
    
//    setupExercises() => {
//        exercises["First one baby!"] = [exercise_1]
//    }
}
