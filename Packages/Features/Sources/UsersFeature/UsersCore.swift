//
//  UsersCore.swift
//  
//
//  Created by Yuki Okudera on 2022/11/23.
//

import Components
import ComposableArchitecture
import Foundation
import Logger
import Models
import UsersApiClient
import WebBrowserFeature

public final class UsersCore: ReducerProtocol {

    public init() {}

    // MARK: - State

    public struct State: Equatable {

        public init(
            currentPage: Int,
            isLoading: Bool,
            isLoadingPage: Bool,
            usersResponse: UsersResponse?,
            webBrowserState: WebBrowserCore.State?
        ) {
            self.currentPage = currentPage
            self.isLoading = isLoading
            self.isLoadingPage = isLoadingPage
            self.usersResponse = usersResponse
            self.webBrowserState = webBrowserState
        }

        public init() {
            self.init(
                currentPage: 1,
                isLoading: false,
                isLoadingPage: false,
                usersResponse: nil,
                webBrowserState: nil
            )
        }

        var currentPage: Int
        var isLoading: Bool
        var isLoadingPage: Bool
        var usersResponse: UsersResponse?
        var webBrowserState: WebBrowserCore.State?
    }

    // MARK: - Action

    public enum Action {
        case onAppear
        case usersResult(Result<UsersResponse, ApiError>)
        case loadingActive(Bool)
        case reachedBottom
        case loadMoreUsersResult(Result<UsersResponse, ApiError>)
        case loadingPageActive(Bool)
        case onTapUser(User)
        case webBrowser(WebBrowserCore.Action)
        case onDismissWebBrowserView
        case onDisappear
    }

    // MARK: - Dependency

    @Dependency(\.usersApiClient) var usersApiClient

    // MARK: - Reducer

    struct CancelId: Hashable {}

    @ReducerBuilderOf<Self>
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .concatenate(
                    .init(value: .loadingActive(true)),
                    .init(value: .loadingPageActive(false)),
                    .run { send in
                        await withThrowingTaskGroup(of: Void.self) { group in
                            group.addTask {
                                do {
                                    let response = try await self.usersApiClient.users(.init(page: 1))
                                    await send(.usersResult(.success(response)))
                                } catch let apiError as ApiError {
                                    await send(.usersResult(.failure(apiError)))
                                }
                            }
                        }
                    }
                )

            case let .usersResult(.success(response)):
                state.currentPage = 2
                state.usersResponse = response
                return .concatenate(
                    .init(value: .loadingActive(false))
                )

            case let .usersResult(.failure(error)):
                log("\(error)")
                return .concatenate(
                    .init(value: .loadingActive(false))
                )

            case let .loadingActive(isLoading):
                state.isLoading = isLoading
                return .none

            case .reachedBottom:
                return .concatenate(
                    .init(value: .loadingActive(false)),
                    .init(value: .loadingPageActive(true)),
                    .run { [currentPage = state.currentPage] send in
                        await withThrowingTaskGroup(of: Void.self) { group in
                            group.addTask {
                                do {
                                    let response = try await self.usersApiClient.users(.init(page: currentPage))
                                    await send(.loadMoreUsersResult(.success(response)))
                                } catch let apiError as ApiError {
                                    await send(.loadMoreUsersResult(.failure(apiError)))
                                }
                            }
                        }
                    }
                )

            case let .loadMoreUsersResult(.success(response)):
                state.currentPage += 1
                state.usersResponse?.append(contentsOf: response)
                return .concatenate(
                    .init(value: .loadingPageActive(false))
                )

            case let .loadMoreUsersResult(.failure(error)):
                log("\(error)")
                return .concatenate(
                    .init(value: .loadingPageActive(false))
                )

            case let .loadingPageActive(isLoading):
                state.isLoadingPage = isLoading
                return .none

            case let .onTapUser(user):
                if let websiteUrl = user.websiteUrl {
                    state.webBrowserState = .init(initialUrl: websiteUrl)
                }
                return .none

            case .webBrowser:
                return .none

            case .onDismissWebBrowserView:
                state.webBrowserState = nil
                return .none

            case .onDisappear:
                return .cancel(
                    id: CancelId()
                )
            }
        }
    }
}
