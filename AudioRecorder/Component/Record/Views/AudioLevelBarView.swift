//
//  AudioLevelBarView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/08/04.
//

import SwiftUI

struct AudioLevelBarView: View {
    let miniHeight: CGFloat = 10
    let maxHeight: CGFloat = 50
    let barHeightRate: Float
    let gradationColors: [Color] = [Color.primary, Color.secondaly]
    let silenceGradationColors: [Color] = [Color.disable]
    var isSilence: Bool {
        barHeightRate == 0
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: isSilence ? silenceGradationColors : gradationColors),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(width: 4, height: maxHeight * CGFloat(barHeightRate) + miniHeight)
    }
}

struct AudioLevelBarView_Previews: PreviewProvider {
    static var previews: some View {
        AudioLevelBarView(barHeightRate: 0.5)
    }
}
