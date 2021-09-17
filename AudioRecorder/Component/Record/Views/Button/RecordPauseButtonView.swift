//
//  RecordPauseButtonView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/09/09.
//

import SwiftUI

// 一時停止ボタン
struct RecordPauseButtonView: View {
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
                Image.system(name: .pause)
                    .renderingMode(.template)
                    .foregroundColor(component.buttonColor)
                    .font(.system(size: 18.0, weight: .bold, design: .default))
            }
            .neonStyle(neonColor: component.neonColor)
        }
    }
}
