//
//  HomeView.swift
//  Training Mask
//
//  Created by Jose Estrella on 9/24/21.
//

import SwiftUI

struct HomeView: View {
    var vm: HomeVM = HomeVM()
    @State private var isCounting = false
    
    @State private var inhale = 01
    @State private var hold = 02
    @State private var exhale = 03
        
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ScrollView{
                LazyVStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(basicExercises) { exercise in
                                StandardExercise(exercise: exercise)
                                    .frame(width: 400, height: 400, alignment: .center)
                                    .padding(.horizontal, 20)
                                
                                
                                
                            }
                        }
                    }
                    Text("\(dd(inhale)) : \(dd(hold)) : \(dd(exhale))").font(.system(size: 70))
                    Image(systemName: "clear")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .opacity(isCounting ? 0.2 : 1)
//                        .scaleEffect(isCounting ? 2 : 1)
                        .rotationEffect(isCounting ? .degrees(90) : .degrees(0))
                        .animation(Animation.easeOut, value: isCounting)
                        .padding()
                    
                    Button(action: {
                        self.inhale = 04
                    }) {
                        Text("update")
                    }
                    Button {self.isCounting.toggle()} label: {
                        Text("Toggle Counter")
                    }
                    
                    
                    Button(action: {
                        print("Pressed")
                    }) {
                        Text("Cancellable")
                    }
//                    .buttonStyle(CancellableButtonStyle())
                    .padding()
                }
            }
            
            
            //            ForEach(vm.allCategories, id: \.self) { category in
            //                ScrollView {
            //                    LazyVStack {
            //                        HStack {
            //                            Text(category).font(.title3).bold().padding(10)
            //                            Spacer()
            //                        }
            //
            //                        ScrollView(.horizontal, showsIndicators: false) {
            //                            HStack {
            //                                ForEach(vm.getExercise(forCat: category)) { exercise in
            //                                    StandardExercise(exercise: exercise)
            //                                        .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            //                                        .padding(.horizontal, 20)
            //
            //                                }
            //                            }
            //                        }
            //                    }
            //                }
            //            }
        }
    }
    
    
    
}

func dd(_ digit: Int) -> String {
    return String(format: "%02d", digit)
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
