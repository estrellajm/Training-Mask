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
    @State var title: String
    //    var description: String?
    @State var image: String
    @State var inhale: Int
    @State var hold: Int
    @State var exhale: Int
    @State var bps: Int
    @State var sets: Int
    
    @State private var isCounting = false // is actively counting
    @State private var isStarted = false // counting has started
    @State private var isActive = true // app is active
    @State private var soundEffect: AVAudioPlayer?
    @State private var playsound = true
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        let time = toMins((inhale + hold + exhale) * bps * sets)
        VStack {
            Spacer()
            VStack{
                Image(image).resizable().frame(width: 350, height: 200)
                Text("\(title)").font(.title).multilineTextAlignment(.center)
                    .padding(.bottom, 10)
            }
            Spacer()
            VStack{
                Text("\(dd(inhale)) : \(dd(hold)) : \(dd(exhale))")
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                Text("  Inhale           Hold          Exhable")
                    .foregroundColor(.yellow)
                //                Text("BPS: \(bps) / \(bps)")
                //                    .padding(.top, 5)
                //                    .font(.title)
                //                    .foregroundColor(Color(UIColor.systemBackground))
                //                Text("Sets: \(sets) / \(sets)")
                //                    .font(.title)
                //                    .foregroundColor(Color(UIColor.systemBackground))
                //                Text("BPS (Breaths Per Set)")
                //                    .font(.footnote)
                //                    .padding(.top, 5)
                //                    .foregroundColor(Color(UIColor.systemBackground))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background(
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .opacity(0.75)
            ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                .onTapGesture{print("Tapped")}
            VStack{
                HStack{
                    Text("BPS: \(bps) / \(bps)").font(.title)
                    Text("|").font(.largeTitle).bold()
                    Text("Sets: \(sets) / \(sets)").font(.title)
                }
                Text("BPS (Breaths Per Set)")
                    .font(.footnote)
                
            }
            .foregroundColor(Color(UIColor.systemBackground))
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .opacity(0.75)
            ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                .onTapGesture{print("Tapped")}
            VStack{
                HStack{
                    Text("Time: ").font(.largeTitle)
                    VStack{
                        Text("Set: \((inhale + hold + exhale) * bps)s")
                        Text("Exercise: \(time)")
                    }
                }
            }
            
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
            guard isCounting && isActive else {return}
            //            if timeRemaining > 0 {
            //                timeRemaining -= 1
            
            if inhale > 0 {
                //                if (playsound) {
                //                    playSound("inhale")
                //                    playsound = false
                //                }
                inhale -= 1
            } else if hold > 0 {
                //                playSound("boop")
                playSound("ping")
                hold -= 1
                playsound = true
            } else if exhale > 0 {
                if (playsound) {
                    playSound("exhale")
                    playsound = false
                }
                exhale -= 1
            } else {
                stop_and_reset()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            isActive = true
        }
    }
    
    func toMins (_ seconds : Int) -> String {
        //        let (h,m,s) = (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
        //        let hrs = seconds / 3600 // exercise will not come close to hours... but a consideration for the future
        let mins = (seconds % 3600) / 60
        let secs = (seconds % 3600) % 60
        return "\(mins)m \(secs)s"
    }
    
    func dd(_ digit: Int) -> String {
        return String(format: "%02d", digit)
    }
    
    func stop_and_reset() {
        isCounting = false
        isStarted = false
        
        inhale = 2
        hold = 1
        exhale = 2
    }
    
    func tap(_ state: String) {
        switch state {
        case "Start":
            isCounting.toggle()
            isStarted.toggle()
            playSound("inhale")
        case "Pause":
            isCounting = false
        case "Resume":
            isCounting = true
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
            CountdownView(title: exercise_1.title, image: exercise_1.image, inhale: exercise_1.inhale, hold: exercise_1.hold, exhale: exercise_1.exhale, bps: exercise_1.breaths_per_set, sets: exercise_1.sets)
        }
    }
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
