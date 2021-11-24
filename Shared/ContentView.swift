//
//  ContentView.swift
//  Shared
//
//  Created by Jose Estrella on 11/23/21.
//

import SwiftUI

struct ContentView: View {
    @State private var isCounting = false
    @State private var isStarted = false
    
    var body: some View {
        VStack {
            Spacer()
            Text("yes")
            Spacer()
            HStack {
                Spacer()
                if (!isStarted) {
                    Button("Start", action: { tap("Start")}).buttonStyle(RoundButtonStyle(color: .green))
                } else {
                    if (!isCounting) {
                        Button("Resume", action: { tap("Resume")}).buttonStyle(RoundButtonStyle(color: .green))
                    } else {
                        Button("Pause", action: { tap("Pause")}).buttonStyle(RoundButtonStyle(color: .orange))
                    }
                    Spacer()
                    Button("Cancel", action: { tap("Cancel") }).buttonStyle(RoundButtonStyle(color: .gray))
                }
//                if (!isCounting) {
//                    if (!isStarted) {
//                        Button("Start", action: { tap("Start")}).buttonStyle(RoundButtonStyle(color: .green))
//                    } else {
//                        Button("Resume", action: { tap("Resume")}).buttonStyle(RoundButtonStyle(color: .green))
//                    }
//                } else {
//                    Button("Pause", action: { tap("Pause")}).buttonStyle(RoundButtonStyle(color: .orange))
//                }
//                Spacer()
//                Button("Cancel", action: { tap("Cancel") }).buttonStyle(RoundButtonStyle(color: .gray))
                Spacer()
            }
        }
    }
    
    func tap(_ state: String) {
        switch state {
        case "Start":
            self.isCounting.toggle()
            self.isStarted.toggle()
            
        case "Pause":
            self.isCounting = false
            
        case "Resume":
            self.isCounting = true
            
        case "Cancel":
            self.isCounting = false
            self.isStarted = false
        default:
            print("Have you done something new?")
        }
    }
    
//    struct RoundButtonStyle: PrimitiveButtonStyle {
//        let color: Color
//
//        func makeBody(configuration: Configuration) -> some View {
//            let val: CGFloat = 120
//            configuration.label
//                .frame(width: val, height: val)
//                .font(.title)
//                .foregroundColor(color == .orange ? .black : .white)
//                .background(color)
//                .clipShape(Circle())
//                .onTapGesture { configuration.trigger() }
//        }
//    }
//
    struct RoundButtonStyle: ButtonStyle {
        let color: Color
        
        func makeBody(configuration: Configuration) -> some View {
            let val: CGFloat = 120
            configuration.label
                .frame(width: val, height: val)
                .font(.title)
                .foregroundColor(color == .orange ? .black : .white)
                .background(configuration.isPressed ? color.opacity(0.5): color)
                .clipShape(Circle())
                .foregroundColor(configuration.isPressed ? .red.opacity(0.5) : .red)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 8)
//                        .stroke(configuration.isPressed ? .red.opacity(0.5) : .red, lineWidth: 1.5)
//                )
        }
    }
    
    struct PrimaryButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding(5)
                .foregroundColor(configuration.isPressed ? .red.opacity(0.5) : .red)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(configuration.isPressed ? .red.opacity(0.5) : .red, lineWidth: 1.5)
                )
         }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
