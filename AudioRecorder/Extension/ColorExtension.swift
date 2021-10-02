//
//  ColorPalette.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/08/04.
//

import SwiftUI

extension Color {
    struct Theme {
        static let yellow = Color("YellowThemeColor")
        static let pink = Color("PinkThemeColor")
        static let purple = Color("PurpleThemeColor")
        static let black = Color("BlackThemeColor")
        static let textColor = Color("TextColor")
        static let white = Color.white
        static let disable = Color.gray
    }
}

extension Font {
    enum CustomName {
        static let helveticaNeueUltraLight = "HelveticaNeue-UltraLight"
        static let helveticaNeueUltraLightItalic = "HelveticaNeue-UltraLightItalic"
        static let helveticaNeueThin = "HelveticaNeue-Thin"
    }
}
