//
//  HomeViewModel.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/09/26.
//

import Combine
import SwiftUI

class HomeViewModel: ObservableObject, SignboardViewProtocol {
    struct Dependency {
        let neonLightTimerAdapter: HomeNeonLightTimerAdapter
        
        static var `default` = Dependency(
            neonLightTimerAdapter: HomeNeonLightTimerAdapter()
        )
    }
    
    @Published var isLightedFrame: Bool = false
    @Published var isLightedTitle: Bool = false
    
    private let dependency: Dependency
    private var cancellables = Set<AnyCancellable>()
    private let isLightedFrameList: [Bool] = [Bool](repeating: true, count: 7) + [Bool](repeating: false, count: 3)
    private let isLightedTitleList: [Bool] = [Bool](repeating: true, count: 19) + [Bool](repeating: false, count: 1)
    
    init(dependency: Dependency = .default) {
        self.dependency = dependency
        
        dependency.neonLightTimerAdapter.lightListPublisher()
            .sink { [weak self] (isLightedFrame: Bool, isLightedTitle: Bool) in
                guard let self = self else { return }
                self.isLightedFrame = isLightedFrame
                self.isLightedTitle = isLightedTitle
            }.store(in: &cancellables)
    }
    
    func startTimer() {
        dependency.neonLightTimerAdapter.startTimer()
    }
    
    func stopTimer() {
        dependency.neonLightTimerAdapter.stopTimer()
    }
}
