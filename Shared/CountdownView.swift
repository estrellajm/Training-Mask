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
    @State var exercise: Exercise
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
    
    @State var bpsTime: Int
    @State var setTime: Int
    @State var exerciseTime: Int
    @State var workoutTime: Int
    
    var body: some View {
        VStack {
            Spacer()
            VStack{
                Text("bpsTime: \(bpsTime)")
                Text("setTime: \(setTime)")
                Text("exerciseTime: \(exerciseTime)")
                Text("workoutTime: \(workoutTime)")
                Image(image).resizable().frame(width: 350, height: 200)
                Text("\(title)").font(.title).multilineTextAlignment(.center)
                    .padding(.bottom, 10)
            }
            Spacer()
            HStack(spacing: 20){
                VStack{
                    Text("\(dd(inhale))")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                    Text("Inhale")
                        .foregroundColor(.yellow)
                }
                Text(":")
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                    .padding(.bottom, 30)
                VStack{
                    Text("\(dd(hold))")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                    Text("Hold")
                        .foregroundColor(.yellow)
                }
                Text(":")
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                    .padding(.bottom, 30)
                VStack{
                    Text("\(dd(exhale))")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                    Text("Exhable")
                        .foregroundColor(.yellow)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .opacity(0.75)
            ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                .onTapGesture{print("Tapped")}
            HStack(spacing: 20){
                HStack(spacing: 30){
                    VStack{
                        Text("\(bps) / \(exercise.breaths_per_set)").font(.title)
                        Text("BPS").font(.footnote).foregroundColor(.yellow)
                        Text("\(timeFormat(bpsTime))")
                    }
                    VStack{
                        Text("\(sets) / \(exercise.sets)").font(.title)
                        Text("Sets").font(.footnote).foregroundColor(.yellow)
                        Text("\(timeFormat(setTime))")
                    }
                }
                .foregroundColor(Color(UIColor.systemBackground))
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .opacity(0.75)
                ).shadow(color: Color.black.opacity(0.5), radius: 10, x: 10, y: 10)
                    .onTapGesture{print("Tapped")}
                VStack{
                    Text("\(timeFormat(exerciseTime))")
                    Text("Exercise").font(.footnote).foregroundColor(.yellow) 
                    Text("\(timeFormat(workoutTime))")
                    Text("Workout").font(.footnote).foregroundColor(.yellow)
                }
                .foregroundColor(Color(UIColor.systemBackground))
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .opacity(0.75)
                ).shadow(color: Color.black.opacity(0.5), radius: 10, x: 10, y: 10)
                    .onTapGesture{print("Tapped")}
            }
            Spacer(minLength: 80)
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
        .onReceive(timer) {_ in
            guard isCounting && isActive else {return}
            timerCountdown()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            isActive = true
        }
    }
    
    func timeFormat (_ seconds : Int) -> String {
        let (h,m,s) = (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
        let hrs = h > 0 ? "\(h)h " : ""
        let mins = m > 0 ? "\(m)m " : ""
        return "\(hrs)\(mins)\(s)s"
    }
    
    func dd(_ digit: Int) -> String {
        return String(format: "%02d", digit)
    }
    
    func stop() {
        isCounting = false
        isStarted = false
    }
    
    func timerCountdown() {
        bpsTime -= 1
        setTime -= 1
        exerciseTime -= 1
        workoutTime -= 1
//        switch timer {
//            case 0:
//                print("You're just starting out")
//
//            case 1:
//                print("You just released iTunes Live From SoHo")
//
//            case 2:
//                print("You just released Speak Now World Tour")
//
//            default:
//                print("Have you done something new?")
//        }
        
        
        if inhale > 0 {
            inhale -= 1
        } else if hold > 0 {
            hold -= 1
        } else if exhale > 1 {
            exhale -= 1
        } else if bps > 1 {
            bps -= 1
            reset("bpsTime")
        } else if sets > 1 {
            sets -= 1
            reset("setTime")
        } else {
            stop_and_reset()
        }

    }

    
    func reset(_ val: String) {
        inhale = exercise.inhale
        hold = exercise.hold
        exhale = exercise.exhale
        
        if (val == "bpsTime") {
            bpsTime = exercise.inhale + exercise.hold + exercise.exhale
        }
        if (val == "setTime") {
            bps = exercise.breaths_per_set
            bpsTime = exercise.inhale + exercise.hold + exercise.exhale
            setTime = (exercise.inhale + exercise.hold + exercise.exhale) * exercise.breaths_per_set
        }
        if (val == "exerciseTime") {
            exerciseTime = ((exercise.inhale + exercise.hold + exercise.exhale) * exercise.breaths_per_set) * sets
        }
    }
    
    func stop_and_reset() {
        isCounting = false
        isStarted = false
        
        inhale = exercise.inhale
        hold = exercise.hold
        exhale = exercise.exhale
        
        bps = exercise.breaths_per_set
        sets = exercise.sets
        
        bpsTime = (exercise.inhale + exercise.hold + exercise.exhale)
        setTime = ((exercise.inhale + exercise.hold + exercise.exhale) * exercise.breaths_per_set)
        exerciseTime = ((exercise.inhale + exercise.hold + exercise.exhale) * exercise.breaths_per_set) * exercise.sets
        workoutTime = (((exercise.inhale + exercise.hold + exercise.exhale) * exercise.breaths_per_set) * exercise.sets * 4)
    }
    
    func tap(_ state: String) {
        switch state {
        case "Start":
            isCounting.toggle()
            isStarted.toggle()
//            playSound("inhale")
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
            CountdownView(
                exercise: exercise_1,
                title: exercise_1.title,
                image: exercise_1.image,
                inhale: exercise_1.inhale,
                hold: exercise_1.hold,
                exhale: exercise_1.exhale,
                bps: exercise_1.breaths_per_set,
                sets: exercise_1.sets,
                bpsTime: (exercise_1.inhale + exercise_1.hold + exercise_1.exhale),
                setTime: ((exercise_1.inhale + exercise_1.hold + exercise_1.exhale) * exercise_1.breaths_per_set),
                exerciseTime: (((exercise_1.inhale + exercise_1.hold + exercise_1.exhale) * exercise_1.breaths_per_set) * exercise_1.sets),
                workoutTime: (((exercise_1.inhale + exercise_1.hold + exercise_1.exhale) * exercise_1.breaths_per_set) * exercise_1.sets * 4)
            )
        }
    }
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
