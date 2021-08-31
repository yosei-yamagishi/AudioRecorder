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
        HStack(alignment: .bottom, spacing: 0) {
            Group {
                Text(timeString.minute)
                    .frame(width: 66, alignment: .center)
                Text(":")
                Text(timeString.second)
                    .frame(width: 66, alignment: .center)
            }
            .font(.custom("Verdana-Bold", size: 42))
            .foregroundColor(Color.Theme.textColor)
        }
    }
}

struct RecordTimeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Theme.black
                .edgesIgnoringSafeArea(.all)
            RecordTimeView(
                timeString: (minute: "00", second: "00", millisecond: "00")
            )
        }
    }
}
