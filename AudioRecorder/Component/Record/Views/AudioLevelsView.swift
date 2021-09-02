//
//  AudioLevelsView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/08/04.
//

import SwiftUI

protocol AudioLevelsViewProtocol: ObservableObject {
    var amplitudeLevels: [Float] { get }
}

struct AudioLevelsView<ViewModel: AudioLevelsViewProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(viewModel.amplitudeLevels, id: \.self) { level in
                AudioLevelBarView(component: AudioLevelBarView.Component(barHeightRate: level))
            }
        }.frame(height: AudioLevelBarView.maxHeight)
    }
}

struct AudioLevelsView_Previews: PreviewProvider {
    static let amplitudeLevels: [Float] = [Float](repeating: 0.5, count: RecordViewModel.amplitudeDisplayCount)
    
    static var previews: some View {
        AudioLevelsView(viewModel: RecordViewModel())
    }
}
