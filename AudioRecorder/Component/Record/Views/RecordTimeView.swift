//
//  RecordTimeView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/08/04.
//

import SwiftUI

struct RecordTimeView: View {
    var timeString: (minute: String, second: String, millisecond: String)
    
    var body: some View {
        HStack(spacing: 0) {
            Group {
                Text(timeString.minute)
                Text(timeString.second)
                Text(timeString.millisecond)
            }
            .foregroundColor(.white)
            .font(.title)
        }
    }
}

struct RecordTimeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            RecordTimeView(
                timeString: (minute: "00", second: "00.", millisecond: "00")
            )
        }
    }
}
