//
//  RecordButtomView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/09/09.
//

import SwiftUI

struct RecordButtomView: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action){
            ZStack {
                Circle()
                    .stroke(Color.Theme.yellow, lineWidth: 2)
                    .frame(width: 60, height: 60, alignment: .center)
                Image(systemName: "mic")
                    .renderingMode(.template)
                    .foregroundColor(Color.Theme.yellow)
                    .font(.system(size: 24.0, weight: .bold, design: .default))
            }
            .frame(width: 60, height: 60)
        }
    }
}
