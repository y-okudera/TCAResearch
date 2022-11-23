//
//  WebBrowserCore.swift
//
//
//  Created by Yuki Okudera on 2022/10/12.
//

import ComposableArchitecture
import Foundation

public final class WebBrowserCore: ReducerProtocol {

    public init() {}

    // MARK: - State

    public struct State: Equatable {

        public init(
            initialUrl: String,
            isLoading: Bool,
            isShownAlert: Bool,
            needsGoBack: Bool,
            needsGoForward: Bool
        ) {
            self.initialUrl = initialUrl
            self.isLoading = isLoading
            self.isShownAlert = isShownAlert
            self.needsGoBack = needsGoBack
            self.needsGoForward = needsGoForward
        }

        public init(initialUrl: String) {
            self.init(
                initialUrl: initialUrl,
                isLoading: false,
                isShownAlert: false,
                needsGoBack: false,
                needsGoForward: false
            )
        }

        var initialUrl: String
        var isLoading: Bool
        var isShownAlert: Bool
        var needsGoBack: Bool
        var needsGoForward: Bool
    }

    // MARK: - Action

    public enum Action: Equatable {
        case onAppear
        case loadingActive(Bool)
        case goBack
        case goForward
        case onDisappear
    }

    // MARK: - Reducer

    struct CancelId: Hashable {}

    @ReducerBuilderOf<Self>
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .concatenate(
                    .init(value: .loadingActive(true))
                )

            case let .loadingActive(isLoading):
                state.isLoading = isLoading
                return .none

            case .goBack:
                return .none

            case .goForward:
                return .none

            case .onDisappear:
                return .cancel(
                    id: CancelId()
                )
            }
        }
    }
}
