//
//  RecorderManager.swift
//  RecordProject
//
//  Created by Yosei Yamagishi on 2020/08/29.
//  Copyright © 2020 Yosei Yamagishi. All rights reserved.
//

import AVFoundation

protocol RecorderManagerDelegate: AnyObject {
    func didFinishRecording()
}

class RecorderManager {
    var amplitudes: [Float] = []
    var originalFileUrl: URL?
    private weak var delegate: RecorderManagerDelegate?
    private let recordFileName: String = "originalAudio.m4a"
    private var recorderHandler = RecorderHandler()
    private var fileHandler = RecorderFileHandler()
    private var sessionHandler = RecorderSessionHandler()
    private var durationTime: TimeInterval? // 収録の最大時間
    
    // 収録の進捗
    var recordProgress: CGFloat? {
        guard let duration = durationTime else { return nil }
        return CGFloat(recorderHandler.currentTime) / CGFloat(duration)
    }
    
    var isRecording: Bool { recorderHandler.isRecording }
    var currentDisplayTime: (minute: String, second: String, millisecond: String) {
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
    
    func setup(delegate: RecorderManagerDelegate) {
        self.delegate = delegate
        // マイクの許可を取る
        sessionHandler.requestPermission { [weak self] granted in
            guard let self = self, granted else { return }
            // セッションをアクティブ
            self.sessionHandler.setActive()
            // 音声ファイルを用意する
            let fileUrl = self.fileHandler.fileUrl(fileName: self.recordFileName)!
            self.originalFileUrl = fileUrl
            // レコーダーをセットアップ
            self.recorderHandler.setup(url: fileUrl, delegate: self)
            print(fileUrl)
        }
    }
    
    // 収録を開始
    func record() {
        recorderHandler.record(durationTime: durationTime)
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
    
    func setupTimer(isOn: Bool) {
        durationTime = isOn ? 30 : nil
    }
}

extension RecorderManager: RecorderHandlerDelegate {
    func didFinishRecording() {
        delegate?.didFinishRecording()
    }
}
