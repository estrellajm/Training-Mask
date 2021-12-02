//
//  StandardExercise.swift
//  Training Mask
//
//  Created by Jose Estrella on 9/24/21.
//

import SwiftUI

struct StandardExercise: View {
    var exercise: Exercise
    var body: some View {
        
        VStack {
            Image(exercise.image).resizable()
                .aspectRatio(contentMode: .fit)
            Text(exercise.title)
//            HStack {
//                Spacer()
//                Text("Inhale: \(exercise.inhale)")
//                Text("Hold: \(exercise.hold)")
//                Text("exhale: \(exercise.exhale)")
//                Spacer()
//            }
            
        }
    }
}

struct StandardExercise_Previews: PreviewProvider {
    static var previews: some View {
        StandardExercise(exercise: basicExercises[0])
    }
}
