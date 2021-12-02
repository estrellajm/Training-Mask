//
//  ContentView.swift
//  Shared
//
//  Created by Jose Estrella on 11/28/21.
//

import SwiftUI

struct ResultView: View {
    var choice: String
    
    var body: some View {
        Text("You chose \(choice)")
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack(spacing:30){
//                Text("You're going to flip a coin - do you want to choose heads or tails?")
//                NavigationLink(destination: CountdownView(exercise: exercise_1)) {
//                    Text("Exercise")
//                }
//                NavigationLink(destination: ResultView(choice: "Heads")) {
//                    Text("Choose Heads")
//                }
//                NavigationLink(destination: ResultView(choice: "Tails")) {
//                    Text("Choose Tails")
//                }
                
                CountdownView(exercise: basicExercises[3])
            }
        }
        .navigationBarTitle("Navigation", displayMode: .inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
