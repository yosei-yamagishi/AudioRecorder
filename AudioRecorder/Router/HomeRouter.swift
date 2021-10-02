//
//  HomeRouter.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/09/26.
//

import SwiftUI

// [参考] https://qiita.com/noppefoxwolf/items/5c952f6d39568b990b8e
class HomeRouter: ObservableObject {
    let defaultTag: Int = 999
    @Published var destination: AnyView? = nil
    @Published var tag: Int? = nil
    
    func pushRecordView(viewModel: RecordViewModel) {
        self.destination = AnyView(RecordView(viewModel: viewModel))
        self.tag = self.defaultTag
    }
}
