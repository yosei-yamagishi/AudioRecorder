//
//  HomeNeonLightTimerAdapter.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/10/02.
//

import Combine
import SwiftUI

class HomeNeonLightTimerAdapter {
    private let lightListSubject = PassthroughSubject<(isLightedFrame: Bool, isLightedTitle: Bool), Never>()
    
    private var timerCancellable: AnyCancellable?
    private let isLightedFrameList: [Bool] = [Bool](repeating: true, count: 7) + [Bool](repeating: false, count: 3)
    private let isLightedTitleList: [Bool] = [Bool](repeating: true, count: 19) + [Bool](repeating: false, count: 1)
    
    func lightListPublisher() -> AnyPublisher<(isLightedFrame: Bool, isLightedTitle: Bool), Never> {
        lightListSubject.eraseToAnyPublisher()
    }
    
    func startTimer() {
        self.timerCancellable = Timer.publish(every: 0.5, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] timer in
                guard
                    let self = self,
                    let isLightedFrame = self.isLightedFrameList.randomElement(),
                    let isLightedTitle = self.isLightedTitleList.randomElement()
                else { return }
                self.lightListSubject.send((isLightedFrame: isLightedFrame, isLightedTitle: isLightedTitle))
            }
    }
    
    func stopTimer() {
        timerCancellable?.cancel()
    }
}
