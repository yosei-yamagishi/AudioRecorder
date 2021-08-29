//
//  RecordControlView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/08/04.
//

import SwiftUI

// 収録操作するView
struct RecordControlView: View {
    @ObservedObject var viewModel: RecordViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 36) {
            playbackButton()
            recordAndPauseButton()
            stopButton()
        }
    }
    
    private func playbackButton() -> some View {
        Button(action: {
            viewModel.play()
        }){
            switch viewModel.recordStatus {
            case .recording, .ready, .pause:
                PlaybackButtonView()
                    .foregroundColor(Color.Theme.disable)
                    .disabled(false)
            case .stop:
                PlaybackButtonView()
                    .foregroundColor(.white)
                    .disabled(true)
            }
        }
    }
    
    private func recordAndPauseButton() -> some View {
        Button(action: {
            viewModel.recordAndPause()
        }){
            switch viewModel.recordStatus {
            case .recording:
                RecordPauseButtonView()
                    .frame(width: 40, height: 40)
            default:
                RecordButtomView()
                    .frame(width: 40, height: 40)
            }
        }
    }
    
    private func stopButton() -> some View {
        Button(action: {
            viewModel.stop()
        }){
            switch self.viewModel.recordStatus {
            case .ready, .stop:
                RecordStopButtonView()
                    .disabled(true)
            default:
                RecordStopButtonView()
                    .foregroundColor(Color.Theme.pink)
                    .disabled(false)
            }
        }
    }
}

// 一時停止ボタン
struct RecordPauseButtonView: View {
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.Theme.pink, lineWidth: 4)
                .frame(width: 60, height: 60, alignment: .center)
            Circle()
                .fill(Color.Theme.pink)
                .frame(width: 50, height: 50, alignment: .center)
            Image(systemName: "pause")
                .renderingMode(.template)
                .foregroundColor(Color.Theme.black)
                .font(.system(size: 36.0, weight: .bold, design: .default))
        }
        .frame(width: 60, height: 60)
    }
}

// 収録ボタン
struct RecordButtomView: View {
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.Theme.yellow, lineWidth: 4)
                .frame(width: 60, height: 60, alignment: .center)
            Circle()
                .fill(Color.Theme.yellow)
                .frame(width: 50, height: 50, alignment: .center)
            Image(systemName: "mic")
                .renderingMode(.template)
                .foregroundColor(Color.Theme.black)
                .font(.system(size: 24.0, weight: .bold, design: .default))
        }
        .frame(width: 60, height: 60)
    }
}

// 収録停止ボタン
struct RecordStopButtonView: View {
    var body: some View {
        Image(systemName: "stop.circle")
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
    }
}

// 収録停止ボタン
struct PlaybackButtonView: View {
    var body: some View {
        Image(systemName: "play.circle")
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
    }
}

struct RecordControlView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Theme.black
                .edgesIgnoringSafeArea(.all)
            RecordControlView(viewModel: RecordViewModel())
        }
    }
}
