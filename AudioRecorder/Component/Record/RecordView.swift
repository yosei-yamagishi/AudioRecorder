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
                    .frame(height: 60)
                RecordOptionView(viewModel: viewModel)
                RecordProgressView(viewModel: viewModel) {
                    VStack(spacing: 12) {
                        RecordStatusTitleView(viewModel: viewModel)
                        RecordTimeView(viewModel: viewModel)
                        AudioLevelsView(viewModel: viewModel)
                    }
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
        Group {
            RecordView()
            RecordView()
                .previewDevice("iPhone 12 mini")
            RecordView()
                .previewDevice("iPad Pro (12.9-inch) (5th generation)")
        }
    }
}
