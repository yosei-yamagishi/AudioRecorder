//
//  CountDownButtonView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/09/20.
//

import SwiftUI

struct CountDownButtonView: View {
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
                Image.system(name: .deskclock)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                    .foregroundColor(component.buttonColor)
            }
        }
        .disabled(component.disable)
        .neonStyle(neonColor: component.neonColor)
    }
}
