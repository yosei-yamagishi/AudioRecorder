//
//  AudioLevelsView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/08/04.
//

import SwiftUI

protocol AudioLevelsViewProtocol: ObservableObject {
    var recordStatus: RecordStatus { get }
    var amplitudeLevels: [Float] { get }
}

struct AudioLevelsView<ViewModel: AudioLevelsViewProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var neonColor: Color {
        switch viewModel.recordStatus {
        case .ready, .stop, .countdown: return Color.Theme.disable
        case .pause: return Color.Theme.pink
        case .recording: return Color.Theme.yellow
        }
    }
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(viewModel.amplitudeLevels, id: \.self) { level in
                AudioLevelBarView(component: AudioLevelBarView.Component(neonColor: neonColor, barHeightRate: level))
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
