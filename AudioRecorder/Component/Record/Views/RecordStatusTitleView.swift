//
//  RecordStatusTitleView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/08/22.
//

import SwiftUI
import Combine

struct RecordStatusTitleView: View {
    @Binding var recordStatus: RecordStatus
    @State var titleTextAnimations: [TextAnimationInfo] = []
    @State var timerCancellable: AnyCancellable?
    @State var timeCounter: Int = 0
    
    var body: some View {
        Group {
            switch self.recordStatus {
            case .stop, .pause, .ready:
                Text(recordStatus.title)
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
        .foregroundColor(Color.Theme.textColor)
        .font(.largeTitle.bold())
        .onChange(of: recordStatus) { status in
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
                        print("###うごいてる")
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
        switch recordStatus {
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
            RecordStatusTitleView(recordStatus: .constant(.ready))
        }
    }
}
