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
                Image.system(name: .stopFill)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .foregroundColor(component.buttonColor)
            }
        }
        .disabled(component.disable)
    }
}

