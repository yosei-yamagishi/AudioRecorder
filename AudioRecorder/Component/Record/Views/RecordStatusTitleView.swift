//
//  RecordStatusTitleView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/08/22.
//

import SwiftUI
import Combine

protocol RecordStatusTitleViewProtocol: ObservableObject {
    var recordStatus: RecordStatus { get }
}
struct RecordStatusTitleView<ViewModel: RecordStatusTitleViewProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    @State var titleTextAnimations: [TextAnimationInfo] = []
    @State var timerCancellable: AnyCancellable?
    @State var timeCounter: Int = 0
    
    var statusNeonColor: Color {
        switch viewModel.recordStatus {
        case .pause: return Color.Theme.pink
        case .ready: return Color.Theme.white
        case .stop: return Color.Theme.disable
        case .recording: return Color.Theme.yellow
        }
    }
    
    var body: some View {
        Group {
            switch viewModel.recordStatus {
            case .stop, .pause, .ready:
                Text(viewModel.recordStatus.title)
            case .recording:
                HStack(spacing: 0) {
                    ForEach(titleTextAnimations) { text in
                        Text(text.text)
                            .offset(y: text.offset)
                    }
                }
            }
        }
        .frame(height: 40)
        .foregroundColor(statusNeonColor)
        .neonStyle(neonColor: statusNeonColor)
        .font(.custom(Font.CustomName.helveticaNeueUltraLight, size: 42))
        .onChange(of: viewModel.recordStatus) { status in
            switch status {
            case .recording:
                status.title.forEach {
                    titleTextAnimations.append(TextAnimationInfo(text: String($0)))
                }
                self.timerCancellable = Timer.publish(every: 0.3, on: .main, in: .common)
                    .autoconnect()
                    .sink { timer in
                        let index = timeCounter % status.title.count
                        self.animateText(index: index, text: status.title)
                        self.timeCounter += 1
                    }
            default:
                for (index, _) in titleTextAnimations.enumerated() {
                    setOffset(index: index, offset: 0)
                }
                titleTextAnimations.removeAll()
                timerCancellable?.cancel()
                timeCounter = 0
            }
        }
    }
    
    private func animateText(index: Int, text: String) {
        withAnimation(.easeInOut) {
            setOffset(index: index, offset: -10)
            switch index {
            case 0:
                setOffset(index: text.count - 1, offset: 0)
            case text.count - 1:
                setOffset(index: index - 1, offset: 0)
            default:
                setOffset(index: index - 1, offset: 0)
            }
        }
    }
    
    private func setOffset(index: Int, offset: CGFloat) {
        switch viewModel.recordStatus {
        case .recording:
            titleTextAnimations[index].offset = offset
        default:
            break
        }
    }
}

struct RecordStatusTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Theme.black
                .ignoresSafeArea()
            RecordStatusTitleView(viewModel: RecordViewModel())
        }
    }
}
