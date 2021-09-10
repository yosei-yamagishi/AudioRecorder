//
//  TimerButtonView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/09/09.
//

import SwiftUI

struct TimerButtonView: View {
    struct Component {
        var buttonColor: Color
        var neonColor: Color
        var disable: Bool
    }
    
    let component: Component
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .stroke(component.buttonColor, lineWidth: 2)
                    .frame(width: 40, height: 40, alignment: .center)
                Image(systemName: "timer")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                    .foregroundColor(component.buttonColor)
            }
            .neonStyle(neonColor: component.neonColor)
        }
        .disabled(component.disable)
    }
}
