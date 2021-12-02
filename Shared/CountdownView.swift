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

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

struct CountdownView: View {
    @State var staticExercise: Exercise
    @State private var title: String
    //     private var description: String?
    @State private var image: String
    @State private var inhale: Int
    @State private var hold: Int
    @State private var exhale: Int
    @State private var bps: Int
    @State private var sets: Int
    @State private var bpsTime: Int
    @State private var setTime: Int
    @State private var exerciseTime: Int
    @State private var workoutTime: Int
    
    
    init(exercise: Exercise) {
        self.staticExercise = exercise
        self.title = exercise.title
        self.image = exercise.image
        self.inhale = exercise.inhale
        self.hold = exercise.hold
        self.exhale = exercise.exhale
        self.bps = exercise.breaths_per_set
        self.sets = exercise.sets
        self.bpsTime = (exercise.inhale + exercise.hold + exercise.exhale)
        self.setTime = ((exercise.inhale + exercise.hold + exercise.exhale) * exercise.breaths_per_set)
        self.exerciseTime = (((exercise.inhale + exercise.hold + exercise.exhale) * exercise.breaths_per_set) * exercise.sets)
        self.workoutTime = (((exercise.inhale + exercise.hold + exercise.exhale) * exercise.breaths_per_set) * exercise.sets * 4)
    }
    
    @State private var isCounting = false // is actively counting
    @State private var isStarted = false // counting has started
    @State private var isActive = true // app is active
    @State private var soundEffect: AVAudioPlayer? = nil
    @State private var playsoundActive = true
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    
    var body: some View {
        VStack {
            Spacer()
            VStack{
                Image(image).resizable().aspectRatio(contentMode: .fit).frame(height: 200)
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
                    Text("Exhale")
                        .foregroundColor(.yellow)
                }
            }
            .fixedSize(horizontal: true, vertical: true)
            .frame(width: 300)
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
                        Text("\(bps) / \(staticExercise.breaths_per_set)").font(.title)
                        Text("BPS").font(.footnote).foregroundColor(.yellow)
                        Text("\(timeFormat(bpsTime))")
                    }
                    VStack{
                        Text("\(sets) / \(staticExercise.sets)").font(.title)
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
//                    Text("\(timeFormat(workoutTime))")
//                    Text("Workout").font(.footnote).foregroundColor(.yellow)
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
        
        if inhale > 0 {
            inhale -= 1
        } else if hold > 0 {
            playsoundActive = true
            hold -= 1
            playSound("boop")
        } else if exhale > 1 {
            if (playsoundActive) {
                playSound("exhale")
                playsoundActive.toggle()
            }
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
        inhale = staticExercise.inhale
        hold = staticExercise.hold
        exhale = staticExercise.exhale
        
        if (val == "bpsTime") {
            playSound("inhale")
            bpsTime = staticExercise.inhale + staticExercise.hold + staticExercise.exhale
        }
        if (val == "setTime") {
            bps = staticExercise.breaths_per_set
            bpsTime = staticExercise.inhale + staticExercise.hold + staticExercise.exhale
            setTime = (staticExercise.inhale + staticExercise.hold + staticExercise.exhale) * staticExercise.breaths_per_set
        }
        if (val == "exerciseTime") {
            exerciseTime = ((staticExercise.inhale + staticExercise.hold + staticExercise.exhale) * staticExercise.breaths_per_set) * sets
        }
    }
    
    func stop_and_reset() {
        isCounting = false
        isStarted = false
        
        inhale = staticExercise.inhale
        hold = staticExercise.hold
        exhale = staticExercise.exhale
        
        bps = staticExercise.breaths_per_set
        sets = staticExercise.sets
        
        bpsTime = (staticExercise.inhale + staticExercise.hold + staticExercise.exhale)
        setTime = ((staticExercise.inhale + staticExercise.hold + staticExercise.exhale) * staticExercise.breaths_per_set)
        exerciseTime = ((staticExercise.inhale + staticExercise.hold + staticExercise.exhale) * staticExercise.breaths_per_set) * staticExercise.sets
        workoutTime = (((staticExercise.inhale + staticExercise.hold + staticExercise.exhale) * staticExercise.breaths_per_set) * staticExercise.sets * 4)
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
            CountdownView(
                exercise: basicExercises[7]
            )
        }
    }
}
