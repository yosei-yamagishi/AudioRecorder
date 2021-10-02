//
//  RecordViewModel.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/08/03.
//

import SwiftUI
import Combine

class RecordViewModel: ObservableObject, RecordTimeViewProtocol, AudioLevelsViewProtocol, RecordStatusTitleViewProtocol, RecordProgressViewProtocol {
    
    struct Dependency {
        let recorder: RecorderManager
        let player: PlayerManager
        let countDownAdapter: CountDownAdapter
        
        static var `default` = Dependency(
            recorder: RecorderManager(),
            player: PlayerManager(),
            countDownAdapter: CountDownAdapter()
        )
    }
    
    // 表示する音量の数
    static let amplitudeDisplayCount: Int = 10
    
    private let dependency: Dependency
    private var amplitudeCount: Int = 0
    private var timerCancellable: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
    
    @Published var currentTimeString: (minute: String, second: String, millisecond: String) = ("00", "00", "00")
    @Published var recordStatus: RecordStatus = .ready
    @Published var progress: CGFloat = 0
    @Published var isOnTimer: Bool = false
    @Published var isOnCountDown: Bool = false
    @Published var amplitudeLevels: [Float]
    @Published var countDownType: CountDownType = .three
    
    init(dependency: Dependency = .default) {
        self.dependency = dependency
        amplitudeLevels = [Float](repeating: .zero, count: Self.amplitudeDisplayCount)
    }
    
    func setup() {
        dependency.recorder.setup(delegate: self)
        
        dependency.countDownAdapter.countDownTypePublisher().sink { [weak self] countDownType in
            self?.countDownType = countDownType
        }.store(in: &cancellables)
        
        dependency.countDownAdapter.finishCountDownPublisher().sink { [weak self]  in
            self?._record()
        }.store(in: &cancellables)
    }
    
    private func updateAmpliude() {
        let amplitude = self.dependency.recorder.updateAmpliude()
        self.amplitudeCount += 1
        let index = self.amplitudeCount % Self.amplitudeDisplayCount
        self.amplitudeLevels[index] = amplitude
    }

    private func initAmplitudeLevels() {
        amplitudeLevels = [Float](repeating: .zero, count: Self.amplitudeDisplayCount)
    }
    
    private func _record() {
        recordStatus = .recording
        dependency.recorder.record()
        startTimer()
    }
}

extension RecordViewModel: RecorderManagerDelegate {
    func didFinishRecording() {
        recordStatus = .stop
    }
}

// MARK: Timer

extension RecordViewModel {
    private func startTimer() {
        timerCancellable = Timer.publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] timer in
                guard let self = self else { return }
                self.updateAmpliude()
                if let progress = self.dependency.recorder.recordProgress {
                    self.progress = progress
                }
                self.currentTimeString = self.dependency.recorder.currentDisplayTime
            }
    }
    
    private func stopTimer() {
        timerCancellable?.cancel()
    }
}

extension RecordViewModel: RecordOptionViewProtocol {
    func setupTimer() {
        isOnTimer.toggle()
        dependency.recorder.setupTimer(isOn: isOnTimer)
    }
    
    func setupCountDown() {
        isOnCountDown.toggle()
    }
}

extension RecordViewModel: RecordControlViewProtocol {    
    func record() {
        switch recordStatus {
        case .ready:
            if isOnCountDown {
                recordStatus = .countdown
                dependency.countDownAdapter.startCountDown()
            } else {
                _record()
            }
        case .pause:
            _record()
        default:
            return
        }
    }
    
    func pause() {
        switch recordStatus {
        case .recording:
            recordStatus = .pause
            dependency.recorder.pause()
            stopTimer()
        default:
            return
        }
    }
    
    func stop() {
        switch recordStatus {
        case .recording, .pause:
            recordStatus = .stop
            stopTimer()
            dependency.recorder.stop()
            initAmplitudeLevels()
        default:
            break
        }
    }
    
    func play() {
        switch recordStatus {
        case .stop:
            if let originalUrl = dependency.recorder.originalFileUrl {
                dependency.player.setup(originalUrl: originalUrl)
            }
            dependency.player.play(currentTime: 0)
        default:
            break
        }
    }
}
