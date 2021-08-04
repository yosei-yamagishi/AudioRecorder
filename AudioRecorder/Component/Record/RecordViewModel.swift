//
//  RecordViewModel.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/08/03.
//

import SwiftUI

class RecordViewModel: ObservableObject {
    let recorderManager = RecorderManager()
    let playerManager = PlayerManager()
    
    @Published var currentTimeString: (minute: String, second: String, millisecond: String) = ("00:", "00.", "00")
    @Published var isEnablePlay: Bool = false
    @Published var isRecording: Bool = false
    
    // 表示する音量の数
    static let amplitudeDisplayCount: Int = 10
    // 表示に使用する音量
    @Published var amplitudeLevels: [Float]
    private var amplitudeCount: Int = 0
    private var timer: Timer?
    
    init() {
        amplitudeLevels = [Float](repeating: .zero, count: Self.amplitudeDisplayCount)
    }
    
    func setup() {
        recorderManager.setup()
    }
    
    func recordAndPause() {
        if isRecording {
            isRecording = false
            recorderManager.pause()
            stopTimer()
        } else {
            isRecording = true
            recorderManager.record()
            startTimer()
        }
    }
    
    func stop() {
        isEnablePlay = true
        isRecording = false
        stopTimer()
        recorderManager.stop()
        initAmplitudeLevels()
    }
    
    func play() {
        if let originalUrl = recorderManager.originalFileUrl {
            playerManager.setup(originalUrl: originalUrl)
        }
        playerManager.play(currentTime: 0)
    }
    
    private func startTimer() {
        let timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.updateAmpliude()
            self.currentTimeString = self.recorderManager.currentTime
        }
        self.timer = timer
        RunLoop.current.add(timer, forMode: .common)
    }
    
    private func updateAmpliude() {
        let amplitude = self.recorderManager.updateAmpliude()
        self.amplitudeCount += 1
        let index = self.amplitudeCount % Self.amplitudeDisplayCount
        self.amplitudeLevels[index] = amplitude
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func initAmplitudeLevels() {
        amplitudeLevels = [Float](repeating: .zero, count: Self.amplitudeDisplayCount)
    }
}
