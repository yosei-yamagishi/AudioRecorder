//
//  AudioRecorderApp.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/07/22.
//

import SwiftUI
import UIKit

@main
struct AudioRecorderApp: App {
    
    init() {
        UINavigationBar.setupNavigationBarColor()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView(
                viewModel: HomeViewModel(),
                router: HomeRouter()
            )
        }
    }
}
