//
//  RecorderManager.swift
//  RecordProject
//
//  Created by Yosei Yamagishi on 2020/08/29.
//  Copyright © 2020 Yosei Yamagishi. All rights reserved.
//

import AVFoundation

class RecorderManager {
    var amplitudes: [Float] = []
    var originalFileUrl: URL?
    private let recordFileName: String = "originalAudio.m4a"
    private var recorderHandler = RecorderHandler()
    private var fileHandler = RecorderFileHandler()
    private var sessionHandler = RecorderSessionHandler()
    
    var isRecording: Bool { recorderHandler.isRecording }
    var currentTime: (minute: String, second: String, millisecond: String) {
        let time = recorderHandler.currentTime
        let minute = Int(time / 60)
        let second = Int(time.truncatingRemainder(dividingBy: 60))
        let millisecond = Int(
            (time - Float(minute * 60) - Float(second)) * 100.0
        )
        return (
            minute: String(format: "%02d", minute),
            second: String(format: "%02d", second),
            millisecond: String(format: "%02d", millisecond)
        )
    }
    
    func setup() {
        // マイクの許可を取る
        sessionHandler.requestPermission { [weak self] granted in
            guard let self = self, granted else { return }
            // セッションをアクティブ
            self.sessionHandler.setActive()
            // 音声ファイルを用意する
            let fileUrl = self.fileHandler.fileUrl(fileName: self.recordFileName)!
            self.originalFileUrl = fileUrl
            // レコーダーをセットアップ
            self.recorderHandler.setup(url: fileUrl)
            print(fileUrl)
        }
    }
    
    func record() {
        // 収録を開始
        recorderHandler.record()
    }

    // 音声波形の更新
    func updateAmpliude() -> Float {
        let amplitude = recorderHandler.amplitude()
        amplitudes.append(amplitude)
        return amplitude
    }
    
    func pause() {
        recorderHandler.pause()
    }
    
    func stop() {
        recorderHandler.stop()
    }
}
