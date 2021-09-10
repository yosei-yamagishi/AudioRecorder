//
//  ImageExtension.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/09/10.
//

import SwiftUI

extension Image {
    enum SFSymbolName: String {
        case timer
        case pause
        case mic
        case stopFill = "stop.fill"
        case playFill = "play.fill"
    }
    
    static func system(name: SFSymbolName) -> Image {
        Image(systemName: name.rawValue)
    }
}
