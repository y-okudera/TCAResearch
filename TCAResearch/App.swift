//
//  App.swift
//  TCAResearch
//
//  Created by Yuki Okudera on 2022/11/26.
//

import AppFeature
import Logger
import SwiftUI

// MARK: - App
@main
struct App: SwiftUI.App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            AppView(store: self.appDelegate.store)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .background:
                log("background")
            case .inactive:
                log("inactive")
            case .active:
                log("active")
            @unknown default:
                fatalError("scenePhase is unknown.")
            }
        }
    }
}
