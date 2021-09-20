//
//  CountDownView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/09/18.
//

import SwiftUI
import Combine

struct CountDownView: View {
    var countDownType: CountDownType

    var body: some View {
        Text(countDownType.rawValue.description)
            .foregroundColor(Color.Theme.white)
            .font(.custom(Font.CustomName.helveticaNeueUltraLight, size: 60))
            .frame(width: 60)
    }
}

struct CountDownView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Theme.black
                .ignoresSafeArea()
            CountDownView(countDownType: .three)
        }
    }
}
