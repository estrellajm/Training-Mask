//
//  ContentView.swift
//  Shared
//
//  Created by Jose Estrella on 11/28/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(basicExercises) { exercise in
                    CountdownView(exercise: exercise)
                        .frame(width: 350, alignment: .center)
                        .padding(.horizontal, 20)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
