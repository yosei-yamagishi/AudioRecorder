//
//  RecordView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/07/22.
//

import SwiftUI

struct RecordView: View {
    @StateObject private var viewModel = RecordViewModel()
    
    var body: some View {
        ZStack {
            Color.Theme.black
                .ignoresSafeArea()
            VStack {
                Spacer()
                    .frame(height: 20)
                RecordStatusTitleView(recordStatus: $viewModel.recordStatus)
                Spacer()
                VStack(spacing: 0) {
                    RecordTimeView(timeString: viewModel.currentTimeString)
                    AudioLevelsView(amplitudeLevels: viewModel.amplitudeLevels)
                    
                }
                
                Spacer()
                RecordControlView(viewModel: viewModel)
                Spacer()
                    .frame(height: 32)
            }
            
        }
        .onAppear() {
            viewModel.setup()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
