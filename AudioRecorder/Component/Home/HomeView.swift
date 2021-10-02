//
//  HomeView.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/09/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @ObservedObject var router: HomeRouter
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.Theme.black
                    .ignoresSafeArea()
                VStack {
                    SignboardView(viewModel: viewModel)
                    Spacer()
                        .frame(height: 400)
                    startButton()
                }
            }
            .navigationBarTitle("", displayMode: .inline)
        }
        .onAppear {
            viewModel.startTimer()
        }
    }
    
    private func startButton() -> some View {
        ZStack {
            Button(action: {
                self.viewModel.stopTimer()
                self.router.pushRecordView(viewModel: RecordViewModel())
            }) {
                Text("START")
                    .font(.custom(Font.CustomName.helveticaNeueThin, size: 40))
                    .foregroundColor(Color.Theme.white)
            }
            NavigationLink(
                destination: self.router.destination,
                tag: self.router.defaultTag,
                selection: self.$router.tag
            ) {
                EmptyView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(), router: HomeRouter())
    }
}
