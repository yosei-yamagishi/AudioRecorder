//
//  RecordControlView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/08/04.
//

import SwiftUI

protocol RecordControlViewProtocol: ObservableObject {
    var recordStatus: RecordStatus { get }
    func play()
    func recordAndPause()
    func stop()
}

// 収録操作するView
struct RecordControlView<ViewModel: RecordControlViewProtocol>: View  {
    @ObservedObject var viewModel: ViewModel
    
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
                PlaybackButtonView(component:
                    PlaybackButtonView.Component(
                        buttonColor: Color.Theme.disable,
                        disable: false
                    )
                )
            case .stop:
                PlaybackButtonView(component:
                    PlaybackButtonView.Component(
                        buttonColor: Color.Theme.white,
                        disable: true
                    )
                )
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
            default:
                RecordButtomView()
            }
        }
    }
    
    private func stopButton() -> some View {
        Button(action: {
            viewModel.stop()
        }){
            switch self.viewModel.recordStatus {
            case .ready, .stop:
                RecordStopButtonView(
                    component: RecordStopButtonView.Component(
                        buttonColor: Color.Theme.disable,
                        disable: true
                    )
                )
            default:
                RecordStopButtonView(
                    component: RecordStopButtonView.Component(
                        buttonColor: Color.Theme.pink,
                        disable: false
                    )
                )
            }
        }
    }
}

// 一時停止ボタン
struct RecordPauseButtonView: View {
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.Theme.pink, lineWidth: 2)
                .frame(width: 60, height: 60, alignment: .center)
            Image(systemName: "pause")
                .renderingMode(.template)
                .foregroundColor(Color.Theme.pink)
                .font(.system(size: 24.0, weight: .bold, design: .default))
        }
        .frame(width: 60, height: 60)
    }
}

// 収録ボタン
struct RecordButtomView: View {
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.Theme.yellow, lineWidth: 2)
                .frame(width: 60, height: 60, alignment: .center)
            Image(systemName: "mic")
                .renderingMode(.template)
                .foregroundColor(Color.Theme.yellow)
                .font(.system(size: 24.0, weight: .bold, design: .default))
        }
        .frame(width: 60, height: 60)
    }
}

// 収録停止ボタン
struct RecordStopButtonView: View {
    struct Component {
        var buttonColor: Color
        var disable: Bool
    }
    
    let component: Component
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(component.buttonColor, lineWidth: 2)
                .frame(width: 40, height: 40, alignment: .center)
            Image(systemName: "stop.fill")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 12, height: 12)
                .foregroundColor(component.buttonColor)
        }
        .disabled(component.disable)
    }
}

// 収録停止ボタン
struct PlaybackButtonView: View {
    struct Component {
        var buttonColor: Color
        var disable: Bool
    }
    
    let component: Component
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(component.buttonColor, lineWidth: 2)
                .frame(width: 40, height: 40, alignment: .center)
            Image(systemName: "play.fill")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 14, height: 14)
                .foregroundColor(component.buttonColor)
        }
        .disabled(component.disable)
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
