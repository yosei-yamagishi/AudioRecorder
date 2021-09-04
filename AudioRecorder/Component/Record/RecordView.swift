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
                VStack(spacing: 0) {
                    RecordStatusTitleView(viewModel: viewModel)
                    Spacer()
                        .frame(height: 20)
                    RecordTimeView(viewModel: viewModel)
                    AudioLevelsView(viewModel: viewModel)
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
