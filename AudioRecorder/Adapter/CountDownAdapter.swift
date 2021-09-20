//
//  CountDownAdapter.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/09/18.
//

import SwiftUI
import Combine

class CountDownAdapter {
    private let countDownTypeSubject = CurrentValueSubject<CountDownType, Never> (.three)
    private let finishCountDownSubject = PassthroughSubject<Void, Never>()
    
    private var timerCancellable: AnyCancellable?
    
    func startCountDown() {
        self.timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { timer in
                switch self.countDownTypeSubject.value {
                case .one:
                    self.stopTimer()
                    self.finishCountDownSubject.send(())
                case .two:
                    self.countDownTypeSubject.send(.one)
                case .three:
                    self.countDownTypeSubject.send(.two)
                }
            }
    }
    
    func countDownTypePublisher() -> AnyPublisher<CountDownType, Never> {
        return countDownTypeSubject.eraseToAnyPublisher()
    }
    
    func finishCountDownPublisher() -> AnyPublisher<Void, Never> {
        return finishCountDownSubject.eraseToAnyPublisher()
    }
    
    private func stopTimer() {
        timerCancellable?.cancel()
    }
}
