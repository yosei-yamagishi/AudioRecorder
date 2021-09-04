//
//  NeonStyleModifier.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/09/03.
//

import SwiftUI

struct NeonStyleModifier: ViewModifier {
    var neonColor: Color
    
    func body(content: Content) -> some View {
        content
            .shadow(color: neonColor, radius: 10, x: 0, y: 0)
            .shadow(color: neonColor.opacity(0.6), radius: 3, x: 0, y: 0)
    }
}
