//
//  SignboardView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/10/01.
//

import SwiftUI

protocol SignboardViewProtocol: ObservableObject {
    var isLightedFrame: Bool { get }
    var isLightedTitle: Bool { get }
}

struct SignboardView<ViewModel: SignboardViewProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    private let signboardTitle: String = "RECORDER"
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 2)
                .fill(viewModel.isLightedFrame ? Color.Theme.white : Color.Theme.disable)
                .offset(x: 4, y: 5)
                .frame(width: 320, height: 100)
                .neonStyle(neonColor: viewModel.isLightedFrame ? Color.Theme.white : Color.Theme.disable)
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 2)
                .fill(viewModel.isLightedFrame ? Color.Theme.pink : Color.Theme.disable)
                .frame(width: 320, height: 100)
                .neonStyle(neonColor: viewModel.isLightedFrame ? Color.Theme.pink : Color.Theme.disable)
            Text(signboardTitle)
                .font(.custom(Font.CustomName.helveticaNeueThin, size: 56))
                .foregroundColor(viewModel.isLightedTitle ? Color.Theme.textColor : Color.Theme.disable)
                .offset(x: 3, y: 3)
                .neonStyle(neonColor: viewModel.isLightedTitle ? Color.Theme.textColor : Color.Theme.disable)
            Text(signboardTitle)
                .font(.custom(Font.CustomName.helveticaNeueThin, size: 56))
                .foregroundColor(viewModel.isLightedTitle ? Color.Theme.yellow : Color.Theme.disable)
                .neonStyle(neonColor: viewModel.isLightedTitle ? Color.Theme.yellow : Color.Theme.disable)
        }
    }
}

struct SignboardView_Previews: PreviewProvider {
    static var previews: some View {
        SignboardView(viewModel: HomeViewModel())
    }
}
