//
//  AudioLevelBarView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/08/04.
//

import SwiftUI

struct AudioLevelBarView: View {
    static let miniHeight: CGFloat = 10
    static let maxHeight: CGFloat = 44
    let barHeightRate: Float
    let gradationColors: [Color] = [Color.Theme.yellow, Color.Theme.pink]
    let silenceGradationColors: [Color] = [Color.Theme.disable]
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
            .frame(width: 4, height: Self.maxHeight * CGFloat(barHeightRate) + Self.miniHeight)
    }
}

struct AudioLevelBarView_Previews: PreviewProvider {
    static var previews: some View {
        AudioLevelBarView(barHeightRate: 0.5)
    }
}
