//
//  RecordViewModel.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/08/03.
//

import SwiftUI
import Combine

class RecordViewModel: ObservableObject {
    let recorderManager = RecorderManager()
    let playerManager = PlayerManager()
    
    @Published var currentTimeString: (minute: String, second: String, millisecond: String) = ("00", "00", "00")
    @Published var isEnablePlay: Bool = false
    @Published var recordStatus: RecordStatus = .ready
    
    // 表示する音量の数
    static let amplitudeDisplayCount: Int = 10
    // 表示に使用する音量
    @Published var amplitudeLevels: [Float]
    private var amplitudeCount: Int = 0
    private var timerCancellable: AnyCancellable?
    
    init() {
        amplitudeLevels = [Float](repeating: .zero, count: Self.amplitudeDisplayCount)
    }
    
    func setup() {
        recorderManager.setup()
    }
    
    func recordAndPause() {
        switch recordStatus {
        case .recording:
            recordStatus = .pause
            recorderManager.pause()
            stopTimer()
        case .pause, .ready:
            recordStatus = .recording
            recorderManager.record()
            startTimer()
        case .stop:
            return
        }
    }
    
    func stop() {
        switch recordStatus {
        case .recording, .pause:
            recordStatus = .stop
            isEnablePlay = true
            stopTimer()
            recorderManager.stop()
            initAmplitudeLevels()
        default:
            break
        }
    }
    
    func play() {
        switch recordStatus {
        case .stop:
            if let originalUrl = recorderManager.originalFileUrl {
                playerManager.setup(originalUrl: originalUrl)
            }
            playerManager.play(currentTime: 0)
        default:
            break
        }
    }
    
    private func startTimer() {
        timerCancellable = Timer.publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] timer in
                guard let self = self else { return }
                self.updateAmpliude()
                self.currentTimeString = self.recorderManager.currentTime
            }
    }
    
    private func updateAmpliude() {
        let amplitude = self.recorderManager.updateAmpliude()
        self.amplitudeCount += 1
        let index = self.amplitudeCount % Self.amplitudeDisplayCount
        self.amplitudeLevels[index] = amplitude
    }
    
    private func stopTimer() {
        timerCancellable?.cancel()
    }
    
    private func initAmplitudeLevels() {
        amplitudeLevels = [Float](repeating: .zero, count: Self.amplitudeDisplayCount)
    }
}
