//
//  RecordControlView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/08/04.
//

import SwiftUI

protocol RecordControlViewProtocol: ObservableObject {
    var recordStatus: RecordStatus { get }
    func play()
    func record()
    func pause()
    func stop()
    func setupTimer()
}

// 収録操作するView
struct RecordControlView<ViewModel: RecordControlViewProtocol>: View  {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 36) {
            PlaybackButtonView(component: playbackComponent()) {
                viewModel.play()
            }
            switch viewModel.recordStatus {
            case .recording:
                RecordPauseButtonView {
                    viewModel.pause()
                }
            default:
                RecordButtomView {
                    viewModel.record()
                }
            }
            RecordStopButtonView(component: stopComponent()) {
                viewModel.stop()
            }
        }
    }
    
    private func playbackComponent() -> PlaybackButtonView.Component {
        var component: PlaybackButtonView.Component
        switch viewModel.recordStatus {
        case .recording, .ready, .pause:
            component = PlaybackButtonView.Component(
                buttonColor: Color.Theme.disable,
                disable: false
            )
        case .stop:
            component = PlaybackButtonView.Component(
                buttonColor: Color.Theme.white,
                disable: true
            )
        }
        return component
    }
    
    private func stopComponent() -> RecordStopButtonView.Component {
        var component: RecordStopButtonView.Component
        switch self.viewModel.recordStatus {
        case .ready, .stop:
            component = RecordStopButtonView.Component(
                buttonColor: Color.Theme.disable,
                disable: true
            )
            
        default:
            component = RecordStopButtonView.Component(
                buttonColor: Color.Theme.pink,
                disable: false
            )
            
        }
        return component
    }
}

struct RecordControlView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Theme.black
                .edgesIgnoringSafeArea(.all)
            RecordControlView(viewModel: RecordViewModel())
        }
    }
}
