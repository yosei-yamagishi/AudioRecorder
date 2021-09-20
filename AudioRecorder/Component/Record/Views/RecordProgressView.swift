//
//  RecordProgressView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/09/08.
//

import SwiftUI

protocol RecordProgressViewProtocol: ObservableObject {
    var recordStatus: RecordStatus { get }
    var progress: CGFloat { get }
}

struct RecordProgressView<Content: View, ViewModel: RecordProgressViewProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    var content : Content
    
    var progressColor: Color {
        switch viewModel.recordStatus {
        case .pause: return Color.Theme.pink
        case .ready, .stop, .countdown: return Color.Theme.white
        case .recording: return Color.Theme.yellow
        }
    }
    
    init(viewModel: ViewModel, @ViewBuilder content: () -> Content) {
        self.viewModel = viewModel
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.Theme.disable, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .padding()
                .frame(maxWidth: 500)
            Circle()
                .trim(from: 0, to: viewModel.progress)
                .stroke(progressColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .padding()
                .neonStyle(neonColor: progressColor)
                .frame(maxWidth: 500)
                .rotationEffect(.init(degrees: -90))
            content
        }
    }
}

struct RecordProgressView_Previews: PreviewProvider {
    static var previews: some View {
        RecordProgressView(viewModel: RecordViewModel()) {
            Text("TEST")
        }
    }
}
