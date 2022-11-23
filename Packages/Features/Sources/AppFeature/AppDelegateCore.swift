//
//  AppDelegateCore.swift
//
//
//  Created by Yuki Okudera on 2022/10/10.
//

import ComposableArchitecture
import Logger

public final class AppDelegateCore: ReducerProtocol {

    public init() {}

    // MARK: - State

    public struct State: Equatable {
        public init() {}
    }

    // MARK: - Action

    public enum Action: Equatable {
        case didFinishLaunching
    }

    // MARK: - Reducer

    @ReducerBuilderOf<Self>
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .didFinishLaunching:
                log(".didFinishLaunching")
                return .none
            }
        }
    }
}
