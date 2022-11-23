//
//  AppCore.swift
//
//
//  Created by Yuki Okudera on 2022/10/10.
//

import ComposableArchitecture
import Foundation

public struct AppCore: ReducerProtocol {

    public init() {}

    // MARK: - State

    public struct State: Equatable {

        // swiftlint:disable nesting
        public enum Tab: Equatable {
            case users
            case search
        }

        var appDelegateState: AppDelegateCore.State
        var selectedTab = Tab.users

        public init(appDelegateState: AppDelegateCore.State) {
            self.appDelegateState = appDelegateState
        }
    }

    // MARK: - Action

    public enum Action {
        case appDelegate(AppDelegateCore.Action)
        case selectedTabChange(State.Tab)
    }

    // MARK: - Reducer

    @ReducerBuilderOf<Self>
    public var body: some ReducerProtocol<State, Action> {
        Scope(state: \State.appDelegateState, action: /Action.appDelegate) {
            AppDelegateCore()
        }
        Reduce { state, action in
            switch action {
            case .appDelegate:
                return .none

            case let .selectedTabChange(selectedTab):
                state.selectedTab = selectedTab
                return .none
            }
        }
    }
}
