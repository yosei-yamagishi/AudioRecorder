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
            Button(action: {
                viewModel.play()
            }){
                Image(systemName: "play.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(viewModel.isEnablePlay ? .white : Color.gray)
            }
            .disabled(!viewModel.isEnablePlay)
            
            Button(action: {
                viewModel.recordAndPause()
            }){
                ZStack {
                    Circle()
                        .stroke(viewModel.isRecording ? Color.primary : Color.secondaly, lineWidth: 4)
                        .frame(width: 60, height: 60, alignment: .center)
                    Circle()
                        .fill(viewModel.isRecording ? Color.primary : Color.secondaly)
                        .frame(width: 50, height: 50, alignment: .center)
                    Text(viewModel.isRecording ? "ポーズ" : "収録")
                        .foregroundColor(Color.background)
                        .bold()
                }
                .frame(width: 40, height: 40)
            }
            
            Button(action: {
                viewModel.stop()
            }){
                Image(systemName: "stop.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.primary)
            }
        }
    }
}

struct RecordControlView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            RecordControlView(viewModel: RecordViewModel())
        }
    }
}
