//
//  ContentView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/07/22.
//

import SwiftUI

struct ContentView: View {
    let recorderManager = RecorderManager()
    let playerManager = PlayerManager()
    
    var body: some View {
        VStack {
            Button(action: {
                recorderManager.setup()
            }){
                Text("セットアップ")
            }
            
            Button(action: {
                recorderManager.record()
            }){
                Text("収録開始")
            }
            
            Button(action: {
                recorderManager.pause()
            }){
                Text("一時停止")
            }
            
            Button(action: {
                recorderManager.stop()
            }){
                Text("収録停止")
            }
            
            Button(action: {
                if let originalUrl = recorderManager.originalFileUrl {
                    playerManager.setup(originalUrl: originalUrl)
                }
                playerManager.play(currentTime: 0)
            }){
                Text("再生")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
