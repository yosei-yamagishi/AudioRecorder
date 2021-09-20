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
            RecordPauseButtonView(component: pauseComponent())
            RecordButtomView(component: recordComponent())
            RecordStopButtonView(component: stopComponent())
        }
    }
    
    private func recordComponent() -> RecordButtomView.Component {
        switch viewModel.recordStatus {
        case .recording, .countdown:
            return RecordButtomView.Component(
                buttonColor: Color.Theme.yellow,
                neonColor: Color.Theme.yellow,
                disable: true,
                action: {}
            )
        case .stop:
            return RecordButtomView.Component(
                buttonColor: Color.Theme.disable,
                neonColor: .clear,
                disable: true,
                action: {}
            )
        case .ready, .pause:
            return RecordButtomView.Component(
                buttonColor: Color.Theme.white,
                neonColor: .clear,
                disable: false,
                action: { viewModel.record() }
            )
        }
    }
    
    private func pauseComponent() -> RecordPauseButtonView.Component {
        switch viewModel.recordStatus {
        case .ready, .stop, .countdown:
            return RecordPauseButtonView.Component(
                buttonColor: Color.Theme.disable,
                neonColor: .clear,
                disable: true,
                action: {}
            )
        case .recording:
            return RecordPauseButtonView.Component(
                buttonColor: Color.Theme.white,
                neonColor: .clear,
                disable: false,
                action: { viewModel.pause() }
            )
        case .pause:
            return RecordPauseButtonView.Component(
                buttonColor: Color.Theme.pink,
                neonColor: Color.Theme.pink,
                disable: true,
                action: {}
            )
        }
    }
    
    private func stopComponent() -> RecordStopButtonView.Component {
        switch self.viewModel.recordStatus {
        case .ready, .countdown, .stop:
            return RecordStopButtonView.Component(
                buttonColor: Color.Theme.disable,
                neonColor: .clear,
                disable: true,
                action: {}
            )
        case .pause, .recording:
            return RecordStopButtonView.Component(
                buttonColor: Color.Theme.white,
                neonColor: .clear,
                disable: false,
                action: { viewModel.stop() }
            )
        }
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
