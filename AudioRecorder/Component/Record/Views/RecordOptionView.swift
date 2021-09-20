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
    var isOnCountDown: Bool { get }
    func setupTimer()
    func setupCountDown()
}

struct RecordOptionView<ViewModel: RecordOptionViewProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            TimerButtonView(component: timerComponent()) {
                viewModel.setupTimer()
            }
            CountDownButtonView(component: countDownComponent()) {
                viewModel.setupCountDown()
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
        case .ready:
            component = TimerButtonView.Component(
                buttonColor: buttonColor,
                neonColor: neonColor,
                disable: false
            )
        case .recording, .pause, .countdown:
            component = TimerButtonView.Component(
                buttonColor: buttonColor,
                neonColor: neonColor,
                disable: true
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
    
    private func countDownComponent() -> CountDownButtonView.Component {
        let buttonColor = viewModel.isOnCountDown
            ? Color.Theme.yellow
            : Color.Theme.white
        let neonColor = viewModel.isOnCountDown
            ? Color.Theme.yellow
            : Color.clear
        switch viewModel.recordStatus {
        case .ready:
            return CountDownButtonView.Component(
                buttonColor: buttonColor,
                neonColor: neonColor,
                disable: false
            )
        case .recording, .pause, .countdown:
            return CountDownButtonView.Component(
                buttonColor: buttonColor,
                neonColor: neonColor,
                disable: true
            )
        case .stop:
            return CountDownButtonView.Component(
                buttonColor: buttonColor,
                neonColor: neonColor,
                disable: true
            )
        }
    }
}

struct RecordOptionView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Theme.black
                .ignoresSafeArea()
            RecordOptionView(viewModel: RecordViewModel())
        }
    }
}
