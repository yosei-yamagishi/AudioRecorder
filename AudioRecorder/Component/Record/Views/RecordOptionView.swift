//
//  RecordOptionView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/09/09.
//

import SwiftUI

protocol RecordOptionViewProtocol: ObservableObject {
    var recordStatus: RecordStatus { get }
    var isOnTimer: Bool { get }
    func setupTimer()
}

struct RecordOptionView<ViewModel: RecordOptionViewProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            TimerButtonView(component: timerComponent()) {
                viewModel.setupTimer()
            }
        }
    }
    
    private func timerComponent() -> TimerButtonView.Component {
        var component: TimerButtonView.Component
        let buttonColor = viewModel.isOnTimer
            ? Color.Theme.yellow
            : Color.Theme.white
        let neonColor = viewModel.isOnTimer
            ? Color.Theme.yellow
            : Color.clear
        switch viewModel.recordStatus {
        case .recording, .ready, .pause:
            component = TimerButtonView.Component(
                buttonColor: buttonColor,
                neonColor: neonColor,
                disable: false
            )
        case .stop:
            component = TimerButtonView.Component(
                buttonColor: buttonColor,
                neonColor: neonColor,
                disable: true
            )
        }
        return component
    }
}

struct RecordOptionView_Previews: PreviewProvider {
    static var previews: some View {
        RecordOptionView(viewModel: RecordViewModel())
    }
}
