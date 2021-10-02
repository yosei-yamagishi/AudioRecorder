//
//  NavigationBarExtension.swift
//  AudioRecorder
//
//  Created by Yosei Yamagishi on 2021/10/01.
//

import UIKit

extension UINavigationBar {
    static func setupNavigationBarColor() {
        let background : UIColor = .clear
        let titleColor : UIColor = .white
        let tintColor : UIColor = .white
        
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.backgroundColor = background
        navigationAppearance.shadowColor = background
        navigationAppearance.titleTextAttributes = [.foregroundColor: titleColor]
        navigationAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor]
       
        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().compactAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance
        UINavigationBar.appearance().tintColor = tintColor
    }
}
