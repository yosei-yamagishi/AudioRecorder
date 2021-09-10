//
//  RecordTimeView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/08/04.
//

import SwiftUI

protocol RecordTimeViewProtocol: ObservableObject {
    var currentTimeString: (minute: String, second: String, millisecond: String) { get set }
}

struct RecordTimeView<ViewModel: RecordTimeViewProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            Group {
                Text(viewModel.currentTimeString.minute)
                    .frame(width: 70, alignment: .center)
                Text(":")
                Text(viewModel.currentTimeString.second)
                    .frame(width: 70, alignment: .center)
            }
            .font(.custom(Font.CustomName.helveticaNeueUltraLight, size: 60))
            .foregroundColor(Color.Theme.textColor)
        }
    }
}

struct RecordTimeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Theme.black
                .edgesIgnoringSafeArea(.all)
            RecordTimeView(
                viewModel: RecordViewModel()
            )
        }
    }
}
