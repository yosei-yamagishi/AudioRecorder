//
//  AudioLevelBarView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/08/04.
//

import SwiftUI

protocol AudioLevelBarViewProtocol {
    var neonColor: Color { get }
    var barHeightRate: Float { get }
}

struct AudioLevelBarView: View {
    struct Component: AudioLevelBarViewProtocol {
        let neonColor: Color
        let barHeightRate: Float
    }
    
    static let miniHeight: CGFloat = 10
    static let maxHeight: CGFloat = 44
    let gradationColors: [Color] = [Color.Theme.yellow, Color.Theme.pink]
    let silenceGradationColors: [Color] = [Color.Theme.disable]
    
    let component: AudioLevelBarViewProtocol
    
    var body: some View {
        RoundedRectangle(cornerRadius: 0.5)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: component.barHeightRate == 0 ? silenceGradationColors : gradationColors),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(width: 1, height: Self.maxHeight * CGFloat(component.barHeightRate) + Self.miniHeight)
            .neonStyle(neonColor: component.neonColor)
    }
}

struct AudioLevelBarView_Previews: PreviewProvider {
    static var previews: some View {
        AudioLevelBarView(component: AudioLevelBarView.Component(neonColor: Color.Theme.pink, barHeightRate: 0.5))
    }
}
