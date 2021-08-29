//
//  AudioLevelsView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/08/04.
//

import SwiftUI

struct AudioLevelsView: View {
    let amplitudeLevels: [Float]
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(amplitudeLevels, id: \.self) { level in
                AudioLevelBarView(barHeightRate: level)
            }
        }.frame(height: AudioLevelBarView.maxHeight)
    }
}

struct AudioLevelsView_Previews: PreviewProvider {
    static let amplitudeLevels: [Float] = [Float](repeating: 0.5, count: RecordViewModel.amplitudeDisplayCount)
    
    static var previews: some View {
        AudioLevelsView(amplitudeLevels: Self.amplitudeLevels)
    }
}
