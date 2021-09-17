//
//  RecordStopButtonView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/09/09.
//

import SwiftUI

struct RecordStopButtonView: View {
    struct Component {
        var buttonColor: Color
        var neonColor: Color
        var disable: Bool
        let action: () -> Void
    }
    
    let component: Component
    
    var body: some View {
        Button(action: component.action) {
            ZStack {
                Circle()
                    .stroke(component.buttonColor, lineWidth: 2)
                    .frame(width: 40, height: 40, alignment: .center)
                Image.system(name: .stopFill)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .foregroundColor(component.buttonColor)
            }
        }
        .disabled(component.disable)
        .neonStyle(neonColor: component.neonColor)
    }
}

