//
//  ContentView.swift
//  Shared
//
//  Created by Jose Estrella on 11/23/21.
//

import SwiftUI

struct OtherButtonsView: View {
    @State private var isCounting = false
    
    var body: some View {
        VStack {
            Spacer()
            Text("yes")
            Spacer()
            HStack {
                Spacer()
//                Button("Cancel", action: { self.isCounting = false }).buttonStyle(RoundButtonStyle(color: .gray))
                Spacer()
                if (!isCounting) {
//                    Button("Start", action: { self.isCounting.toggle() }).buttonStyle(RoundButtonStyle(color: .green))
                } else {
//                    Button("Pause", action: { self.isCounting.toggle() }).buttonStyle(RoundButtonStyle(color: .orange))
                }
                
//                Button("Hide") {
//                    print("tapped")
//                }.buttonStyle(PrimaryButtonStyle())
                Spacer()
            }
        }
//        .buttonStyle(isCounting ? BananaButtonStyle(color: .yellow) : BananaButtonStyle(color: .green))
    }

    func tap() { /* implement here */ }
}
struct LargeButtonStyle: ButtonStyle {
    
    let backgroundColor: Color
    let foregroundColor: Color
    let isDisabled: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
        let currentForegroundColor = isDisabled || configuration.isPressed ? foregroundColor.opacity(0.3) : foregroundColor
        return configuration.label
            .padding()
            .foregroundColor(currentForegroundColor)
            .background(isDisabled || configuration.isPressed ? backgroundColor.opacity(0.3) : backgroundColor)
            // This is the key part, we are using both an overlay as well as cornerRadius
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(currentForegroundColor, lineWidth: 1)
        )
            .padding([.top, .bottom], 10)
            .font(Font.system(size: 19, weight: .semibold))
    }
}

//struct PrimaryButtonStyle: ButtonStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .padding(5)
//            .foregroundColor(configuration.isPressed ? Color.red.opacity(0.5) : .red)
//            .overlay(
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(configuration.isPressed ? Color.red.opacity(0.5) : .red, lineWidth: 1.5)
//            )
//     }
//}

//struct LargeButton: View {
//
//    private static let buttonHorizontalMargins: CGFloat = 20
//
//    var backgroundColor: Color
//    var foregroundColor: Color
//
//    private let title: String
//    private let action: () -> Void
//
//    // It would be nice to make this into a binding.
//    private let disabled: Bool
//
//    init(title: String,
//         disabled: Bool = false,
//         backgroundColor: Color = Color.green,
//         foregroundColor: Color = Color.white,
//         action: @escaping () -> Void) {
//        self.backgroundColor = backgroundColor
//        self.foregroundColor = foregroundColor
//        self.title = title
//        self.action = action
//        self.disabled = disabled
//    }
//}

struct OtherButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        OtherButtonsView()
    }
}
