//
//  AppDelegate.swift
//  TCAResearch
//
//  Created by Yuki Okudera on 2022/11/19.
//

import AppFeature
import ComposableArchitecture
import UIKit

// MARK: - AppDelegate
final class AppDelegate: NSObject, UIApplicationDelegate {

    let store = Store<AppCore.State, AppCore.Action>(
        initialState: .init(appDelegateState: .init()),
        reducer: AppCore()
    )

    lazy var viewStore = ViewStore(
        self.store.scope(state: { _ in () }),
        removeDuplicates: ==
    )

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        self.viewStore.send(.appDelegate(.didFinishLaunching))
        return true
    }
}
