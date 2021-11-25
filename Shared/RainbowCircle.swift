//
//  RainbowCircle.swift
//  Countdown
//
//  Created by Jose Estrella on 11/25/21.
//

import SwiftUI

struct RainbowCircle: View {
    @State var progressValue: Float = 2.0
    
    var lineWidth: CGFloat = CGFloat(20)
    var trimLine: CGFloat = CGFloat(0.7)
    
    private let gradient = AngularGradient(
        gradient: Gradient(colors: [.blue, .red, .orange]),
        center: .center,
        startAngle: .degrees(389),
        endAngle: .degrees(180)
    )
    
    var body: some View {
        ZStack {
            //            Color.yellow
            //                .opacity(0.1)
            //                .edgesIgnoringSafeArea(.all)
            //            VStack {
            //                ProgressBar(progress: self.$progressValue)
            //                    .frame(width: 150.0, height: 150.0)
            //                    .padding(20.0)
            //            }
            Spacer()
            Circle().stroke(.blue.opacity(0.1), lineWidth: lineWidth)
            Circle()
                .trim(from: 0, to: trimLine)
                .rotation(Angle.degrees(145))
                .stroke(gradient, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
//                .overlay(
//                    Circle()
//                        .trim(from: 0, to: trimLine)
//                        .rotation(Angle.degrees(270))
//                        .stroke(gradient, style: StrokeStyle(lineWidth: lineWidth, lineCap: .butt))
//                        .overlay(
//                            Circle()
//                                .trim(from: 0, to: trimLine)
//                                .rotation(Angle.degrees(180))
//                                .stroke(gradient, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
//                        )
//                )
            
        }
        .padding(60)
    }
}

struct ProgressBar: View {
    @Binding var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.red)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.red)
                .rotationEffect(Angle(degrees: 180.0))
            //                .animation(.linear, value: self.progress)
            Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
                .font(.largeTitle)
                .bold()
        }
    }
}

struct RainbowCircle_Previews: PreviewProvider {
    static var previews: some View {
        RainbowCircle()
    }
}
