//
//  TextAnimationInfo.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/08/23.
//

import SwiftUI

struct TextAnimationInfo: Identifiable {
    var id = UUID().uuidString
    var text: String
    var offset: CGFloat = 0
}
