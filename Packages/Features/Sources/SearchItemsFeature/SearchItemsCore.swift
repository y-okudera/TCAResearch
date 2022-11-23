//
//  SearchItemsCore.swift
//
//
//  Created by Yuki Okudera on 2022/10/16.
//

import Components
import ComposableArchitecture
import ItemsApiClient
import Foundation
import Logger
import Models
import SearchHistoryClient
import WebBrowserFeature

public final class SearchItemsCore: ReducerProtocol {

    public init() {}

    // MARK: - State

    public struct State: Equatable {

        public init(
            searchQuery: String,
            currentPage: Int,
            isLoading: Bool,
            isLoadingPage: Bool,
            items: ItemsResponse,
            webBrowserState: WebBrowserCore.State?
        ) {
            self.searchQuery = searchQuery
            self.currentPage = currentPage
            self.isLoading = isLoading
            self.isLoadingPage = isLoadingPage
            self.items = items
            self.webBrowserState = webBrowserState
        }

        public init() {
            self.init(
                searchQuery: "",
                currentPage: 1,
                isLoading: false,
                isLoadingPage: false,
                items: [],
                webBrowserState: nil
            )
        }

        var searchQuery: String
        var currentPage: Int
        var isLoading: Bool
        var isLoadingPage: Bool
        var items: ItemsResponse
        var webBrowserState: WebBrowserCore.State?
    }

    // MARK: - Action

    public enum Action: Equatable {
        case searchQueryChanged(String)
        case search
        case reachedBottom
        case itemsResult(Result<ItemsResponse, ApiError>)
        case failedToSaveSearchHistory(DatabaseError)
        case loadMoreItemsResponse(Result<ItemsResponse, ApiError>)
        case loadingActive(Bool)
        case loadingPageActive(Bool)
        case onTapItem(Item)
        case webBrowser(WebBrowserCore.Action)
        case onDismissWebBrowserView
        case onDisappear
    }

    @Dependency(\.itemsApiClient) var itemsApiClient
    @Dependency(\.searchHistoryClient) var searchHistoryClient

    // MARK: - Reducer

    struct CancelId: Hashable {}

    @ReducerBuilderOf<Self>
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case let .searchQueryChanged(searchQuery):
                state.searchQuery = searchQuery
                return .none

            case .search:
                return .concatenate(
                    .init(value: .loadingActive(true)),
                    .init(value: .loadingPageActive(false)),
                    .task { [searchQuery = state.searchQuery] in
                        do {
                            let response = try await self.itemsApiClient.items(.init(page: 1, query: searchQuery))
                            return .itemsResult(.success(response))
                        } catch let apiError as ApiError {
                            return .itemsResult(.failure(apiError))
                        }
                    }
                )

            case .reachedBottom:
                return .concatenate(
                    .init(value: .loadingActive(false)),
                    .init(value: .loadingPageActive(true)),
                    .task { [searchQuery = state.searchQuery, currentPage = state.currentPage] in
                        do {
                            let response = try await self.itemsApiClient.items(.init(page: currentPage, query: searchQuery))
                            return .loadMoreItemsResponse(.success(response))
                        } catch let apiError as ApiError {
                            return .loadMoreItemsResponse(.failure(apiError))
                        }
                    }
                )

            case let .itemsResult(.success(response)):
                state.currentPage = 2
                state.items = response
                return .task { [searchQuery = state.searchQuery] in
                    do {
                        try await self.searchHistoryClient.saveSearchHistory(searchQuery)
                        return .loadingActive(false)
                    } catch let databaseError as DatabaseError {
                        return .failedToSaveSearchHistory(databaseError)
                    }
                }

            case let .itemsResult(.failure(error)):
                log("\(error)")
                return .concatenate(
                    .init(value: .loadingActive(false))
                )

            case let .failedToSaveSearchHistory(databaseError):
                log("databaseError: \(databaseError)")
                return .concatenate(
                    .init(value: .loadingActive(false))
                )

            case let .loadMoreItemsResponse(.success(response)):
                state.currentPage += 1
                state.items.append(contentsOf: response)
                return .concatenate(
                    .init(value: .loadingPageActive(false))
                )

            case let .loadMoreItemsResponse(.failure(error)):
                log("\(error)")
                return .concatenate(
                    .init(value: .loadingPageActive(false))
                )

            case let .loadingActive(isLoading):
                state.isLoading = isLoading
                return .none

            case let .loadingPageActive(isLoading):
                state.isLoadingPage = isLoading
                return .none

            case let .onTapItem(item):
                state.webBrowserState = .init(initialUrl: item.url)
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
