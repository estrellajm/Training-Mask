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
    @State private var index = 0
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            ScrollView{
                LazyVStack {
                    ScrollView(.horizontal, showsIndicators: false) {
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
        }
    }
    
//    var body: some View {
////        VStack {
////            CountdownView(exercise: basicExercises[self.index])
////            Text("\(self.index)")
////            Button{
////                self.index += 1
////            } label: {Text("NEXT")}
////        }
////        NavigationView{
////            ScrollView {
//////                Text("You're going to flip a coin - do you want to choose heads or tails?")
//////                NavigationLink(destination: CountdownView(exercise: exercise_1)) {
//////                    Text("Exercise")
//////                }
//////                NavigationLink(destination: ResultView(choice: "Heads")) {
//////                    Text("Choose Heads")
//////                }
//////                NavigationLink(destination: ResultView(choice: "Tails")) {
//////                    Text("Choose Tails")
//////                }
////
////            }
////        }
//////        .navigationBarTitle("Navigation", displayMode: .inline)
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
