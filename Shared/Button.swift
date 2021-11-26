////
////  Button.swift
////  Countdown
////
////  Created by Jose Estrella on 11/26/21.
////
//
//import SwiftUI
//
//struct Button: View {
//
//    var isStarted: Bool
//
//    var body: some View {
//        HStack {
//            Spacer()
//            // Hides the 'CANCEL' button
//            if (!isStarted) {
//                Button("Start", action: { tap("Start")}).buttonStyle(RoundButtonStyle(color: .green))
//            } else {
//                if (!isCounting) {
//                    Button("Resume", action: { tap("Resume")}).buttonStyle(RoundButtonStyle(color: .green))
//                } else {
//                    Button("Pause", action: { tap("Pause")}).buttonStyle(RoundButtonStyle(color: .orange))
//                }
//                Spacer()
//                Button("Cancel", action: { tap("Cancel") }).buttonStyle(RoundButtonStyle(color: .gray))
//            }
//            //                // Keeps the 'CANCEL' button
//            //                if (!isCounting) {
//            //                    if (!isStarted) {
//            //                        Button("Start", action: { tap("Start")}).buttonStyle(RoundButtonStyle(color: .green))
//            //                    } else {
//            //                        Button("Resume", action: { tap("Resume")}).buttonStyle(RoundButtonStyle(color: .green))
//            //                    }
//            //                } else {
//            //                    Button("Pause", action: { tap("Pause")}).buttonStyle(RoundButtonStyle(color: .orange))
//            //                }
//            //                Spacer()
//            //                Button("Cancel", action: { tap("Cancel") }).buttonStyle(RoundButtonStyle(color: .gray))
//            Spacer()
//        }
//    }
//}
//
//struct Button_Previews: PreviewProvider {
//    static var previews: some View {
//        Button()
//    }
//}
//
//struct RoundButtonStyle: ButtonStyle {
//    let color: Color
//
//    func makeBody(configuration: Configuration) -> some View {
//        let val: CGFloat = 130
//        configuration.label
//            .frame(width: val, height: val)
//            .font(.title)
//            .foregroundColor(color == .orange ? .black : .white)
//            .background(configuration.isPressed ? color.opacity(0.5): color)
//            .clipShape(Circle())
//            .foregroundColor(configuration.isPressed ? color.opacity(0.5) : color)
//            .padding(5)
//            .background(
//                Circle()
//                    .fill(color.opacity(0.75))
//                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
//                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
//
//
//                    .overlay(
//                        Circle()
//                            .stroke(Color.gray, lineWidth: 4)
//                            .blur(radius: 4)
//                            .offset(x: 2, y: 2)
//                            .mask(Circle().fill(LinearGradient(Color.black, Color.clear)))
//                    )
//                    .overlay(
//                        Circle()
//                            .stroke(Color.white, lineWidth: 8)
//                            .blur(radius: 4)
//                            .offset(x: -2, y: -2)
//                            .mask(Circle().fill(LinearGradient(Color.clear, Color.black)))
//                    )
//            )
//    }
//}
