//
//  RecorderHandler.swift
//  RecordProject
//
//  Created by Yosei Yamagishi on 2020/09/18.
//  Copyright © 2020 Yosei Yamagishi. All rights reserved.
//

import AVFoundation

protocol RecorderHandlerDelegate: AnyObject {
    func didFinishRecording()
}

class RecorderHandler: NSObject {
    static let settings: [String: Any] = [
        AVFormatIDKey: kAudioFormatMPEG4AAC, // コーデックを指定
        AVEncoderAudioQualityKey: AVAudioQuality.medium.rawValue, // 品質
        AVNumberOfChannelsKey: 1, // モノラル
        AVSampleRateKey: 44100 // サンプルレート
    ]
    
    private var recorder: AVAudioRecorder?
    private weak var delegate: RecorderHandlerDelegate?
    
    // 収録開始されているかどうか
    var isStarted: Bool { currentTime != 0 }
    // 収録中かどうかのフラグ
    var isRecording: Bool { recorder?.isRecording ?? false }
    // 現在時刻
    var currentTime: Float { Float(self.recorder?.currentTime ?? 0) }
    // 収録開始
    func record(durationTime: TimeInterval? = nil) {
        if isStarted {
            recorder?.record()
            return
        }
        
        if let durationTime = durationTime {
            recorder?.record(atTime: 0, forDuration: durationTime)
        } else {
            recorder?.record()
        }
    }
    // 収録一時停止
    func pause() { recorder?.pause() }
    // 収録停止
    func stop() { recorder?.stop() }
    
    func setup(url: URL, delegate: RecorderHandlerDelegate) {
        self.delegate = delegate
        self.recorder = try! AVAudioRecorder(url: url, settings: Self.settings)
        recorder?.delegate = self
        recorder?.isMeteringEnabled = true // デシベルを抽出を有効にする
        recorder?.prepareToRecord() // レコーダーに収録準備させる
    }
    
    func amplitude() -> Float {
        self.recorder?.updateMeters()
        // 指定されたチャネルの平均パワーをデシベル単位で返却
        // averagePowerは 0dB:最大電力 -160dB:最小電力(ほぼ無音)
        let decibel = recorder?.averagePower(forChannel: 0) ?? 0
        // デシベルから振幅を取得する
        let amp = pow(10, decibel / 20)
        return max(0, min(amp, 1)) // 0...1の間の値
    }
}

extension RecorderHandler: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        delegate?.didFinishRecording()
    }
}
