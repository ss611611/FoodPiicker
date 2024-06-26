//
//  FoodPiickerApp.swift
//  FoodPiicker
//
//  Created by Jackie Lu on 2024/5/21.
//

import SwiftUI

@main
struct AppEntry: App {
    
    init() {
        applyTabBackground()
    }
    var body: some Scene {
        WindowGroup {
            HomeScreen()
        }
    }
    
    func applyTabBackground() {
        let tabBarAppeance = UITabBarAppearance()
        tabBarAppeance.configureWithTransparentBackground()
        tabBarAppeance.backgroundColor = .secondarySystemBackground.withAlphaComponent(0.3)
        tabBarAppeance.backgroundEffect = UIBlurEffect(style: .systemChromeMaterial)
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppeance
    }
}
