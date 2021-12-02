//
//  PopupNav.swift
//  Countdown
//
//  Created by Jose Estrella on 11/28/21.
//

import SwiftUI
import Foundation
import AVFoundation
import AVKit

struct PopupNav: View {
    
    @State var showPicker = false
    
    var body: some View {
        //        Color(UIColor.systemIndigo).ignoresSafeArea(.all, edges: .bottom)
        ZStack{
            NavigationView{
                Text("Add Something")
                    .navigationBarTitle("Home", displayMode: .inline)
                    .navigationBarItems(leading:
                                            Image("bg")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .clipShape(Circle()),
                                        trailing:
                                            Button(action: {
                        withAnimation{ self.showPicker.toggle() }
                    },
                                                   label: {
                        Text("PopUp").onTapGesture {
                            withAnimation {
                                self.showPicker.toggle()
                            }
                        }
                    })
                )
            }
            
            if self.showPicker{
                GeometryReader{_ in
                    Menu()
                }.background(Color.black.opacity(0.65)
                                .edgesIgnoringSafeArea(.all)
                                .onTapGesture {
                    withAnimation {
                        self.showPicker.toggle()
                    }
                })
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        
    }
}

struct PopupNav_Previews: PreviewProvider {
    static var previews: some View {
        PopupNav()
    }
}
struct Menu : View {
    @State var title = "Well"
    @State var inhale = 0
    @State var hold = 0
    @State var exhale = 0
    
    var seconds = [Int](0...60)
    
    var body: some View {
        ZStack{
            Spacer()
            VStack(alignment: .leading, spacing: 15) {
                Picker(selection: self.$inhale, label: Text(self.title)) {
                    ForEach(0 ..< self.seconds.count) { index in
                        Text("\(dd(self.seconds[index]))").tag(index)
                    }
                }
                .pickerStyle(.wheel)
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .cornerRadius(15)
            
            Spacer()
        }
    }
}

