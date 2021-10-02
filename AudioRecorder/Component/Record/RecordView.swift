//
//  RecordView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/07/22.
//

import SwiftUI

struct RecordView: View {
    @StateObject var viewModel: RecordViewModel
    
    var body: some View {
        ZStack {
            Color.Theme.black
                .ignoresSafeArea()
            VStack {
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
            RecordView(viewModel: RecordViewModel())
            RecordView(viewModel: RecordViewModel())
                .previewDevice("iPhone 12 mini")
            RecordView(viewModel: RecordViewModel())
                .previewDevice("iPad Pro (12.9-inch) (5th generation)")
        }
    }
}
