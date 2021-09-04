//
//  RecordStatus.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/08/23.
//

enum RecordStatus {
    case ready
    case recording
    case pause
    case stop
    
    var title: String {
        switch self {
        case .ready: return "Ready?"
        case .recording: return "Recording"
        case .pause: return "Pause"
        case .stop: return "Stop"
        }
    }
}
