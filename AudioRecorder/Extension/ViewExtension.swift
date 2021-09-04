//
//  ViewExtension.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/09/03.
//

import SwiftUI

extension View {
    func neonStyle(neonColor: Color) -> some View {
        self.modifier(NeonStyleModifier(neonColor: neonColor))
    }
}
