//
//  ContentView.swift
//  Shared
//
//  Created by Jose Estrella on 11/23/21.
//

import SwiftUI
import Foundation
import AVFoundation
import AVKit

struct CountdownView: View {
    @State private var isCounting = false // is actively counting
    @State private var isStarted = false // counting has started
    
    @State private var isActive = true // app is active
    
    @State private var inhale = 2
    @State private var pause = 1
    @State private var exhale = 2
    
    @State private var soundEffect: AVAudioPlayer?
    @State private var playsound = true
    
    let tttt = Timer() // testing REMOVE
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Spacer()
            VStack{
                Text("\(dd(inhale)) : \(dd(pause)) : \(dd(exhale))")
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                Text("  Inhale           Hold          Exhable")
                    .foregroundColor(.yellow)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background(
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .opacity(0.75)
            ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                .onTapGesture{print("Tapped")}
            
            Spacer()
            HStack {
                Spacer()
                // Hides the 'CANCEL' button
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
                //                // Keeps the 'CANCEL' button
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
        .onReceive(timer) { time in
            guard self.isCounting && self.isActive else {return}
            //            if self.timeRemaining > 0 {
            //                self.timeRemaining -= 1
            
            if self.inhale > 0 {
                //                if (self.playsound) {
                //                    playSound("inhale")
                //                    self.playsound = false
                //                }
                self.inhale -= 1
            } else if self.pause > 0 {
                //                playSound("boop")
                playSound("ping")
                self.pause -= 1
                self.playsound = true
            } else if self.exhale > 0 {
                if (self.playsound) {
                    playSound("exhale")
                    self.playsound = false
                }
                self.exhale -= 1
            } else {
                stop_and_reset()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            self.isActive = true
        }
    }
    
    func dd(_ digit: Int) -> String {
        return String(format: "%02d", digit)
    }
    
    func stop_and_reset() {
        self.tttt.invalidate()
        
        self.isCounting = false
        self.isStarted = false
        
        self.inhale = 2
        self.pause = 1
        self.exhale = 2
        //        self.timeRemaining = 15
    }
    
    func tap(_ state: String) {
        switch state {
        case "Start":
            self.isCounting.toggle()
            self.isStarted.toggle()
            playSound("inhale")
        case "Pause":
            self.isCounting = false
        case "Resume":
            self.isCounting = true
        case "Cancel":
            stop_and_reset()
            
        default:
            print("Have you done something new?")
        }
    }
    
    func playSound(_ sound: String) {
        let path = Bundle.main.path(forResource: "\(sound).m4a", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            soundEffect = try AVAudioPlayer(contentsOf: url)
            soundEffect?.play()
            soundEffect?.setVolume(0.1, fadeDuration: 1)
        } catch {
            print(error)
        }
    }
    
    struct RoundButtonStyle: ButtonStyle {
        let color: Color
        
        func makeBody(configuration: Configuration) -> some View {
            let val: CGFloat = 130
            configuration.label
                .frame(width: val, height: val)
                .font(.title)
                .foregroundColor(color == .orange ? .black : .white)
                .background(configuration.isPressed ? color.opacity(0.5): color)
                .clipShape(Circle())
                .foregroundColor(configuration.isPressed ? color.opacity(0.5) : color)
                .padding(5)
                .background(
                    Circle()
                        .fill(color.opacity(0.75))
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                        .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                    
                    
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 4)
                                .blur(radius: 4)
                                .offset(x: 2, y: 2)
                                .mask(Circle().fill(LinearGradient(Color.black, Color.clear)))
                        )
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 8)
                                .blur(radius: 4)
                                .offset(x: -2, y: -2)
                                .mask(Circle().fill(LinearGradient(Color.clear, Color.black)))
                        )
                )
        }
    }
    
    struct CountdownView_Previews: PreviewProvider {
        static var previews: some View {
            CountdownView()
        }
    }
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
