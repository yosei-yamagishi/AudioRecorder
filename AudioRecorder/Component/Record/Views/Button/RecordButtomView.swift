//
//  RecordButtomView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/09/09.
//

import SwiftUI

struct RecordButtomView: View {
    struct Component {
        var buttonColor: Color
        var neonColor: Color
        var disable: Bool
        let action: () -> Void
    }
    
    let component: Component
    
    var body: some View {
        Button(action: component.action){
            ZStack {
                Circle()
                    .stroke(component.buttonColor, lineWidth: 2)
                    .frame(width: 60, height: 60, alignment: .center)
                Image.system(name: .mic)
                    .renderingMode(.template)
                    .foregroundColor(component.buttonColor)
                    .font(.system(size: 24.0, weight: .bold, design: .default))
            }
            .frame(width: 60, height: 60)
        }
        .disabled(component.disable)
        .neonStyle(neonColor: component.neonColor)
    }
}
