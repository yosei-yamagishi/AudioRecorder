//
//  RecordPauseButtonView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/09/09.
//

import SwiftUI

// 一時停止ボタン
struct RecordPauseButtonView: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            
            ZStack {
                Circle()
                    .stroke(Color.Theme.pink, lineWidth: 2)
                    .frame(width: 60, height: 60, alignment: .center)
                Image(systemName: "pause")
                    .renderingMode(.template)
                    .foregroundColor(Color.Theme.pink)
                    .font(.system(size: 24.0, weight: .bold, design: .default))
            }
            .frame(width: 60, height: 60)
        }
    }
}
