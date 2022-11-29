//
//  SearchItemsView.swift
//
//
//  Created by Yuki Okudera on 2022/10/16.
//

import Components
import ComposableArchitecture
import FeatureUtils
import Logger
import NavigationSearchBar
import SwiftUI
import WebBrowserFeature

// MARK: - SearchItemsView
public struct SearchItemsView: View {

    let store: Store<SearchItemsCore.State, SearchItemsCore.Action>

    public init(store: Store<SearchItemsCore.State, SearchItemsCore.Action>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in

            ScrollView {
                if viewStore.state.isLoading {
                    VStack {
                        Spacer()
                        ProgressView()
                            .frame(width: 120, height: 120, alignment: .center)
                        Spacer()
                    }
                } else {
                    LazyVStack {
                        ForEach(viewStore.state.items, id: \.id) { item in
                            ItemView(item: item)
                                .id(item.id)
                                .onTapGesture { viewStore.send(.onTapItem(item)) }
                        }
                        if !viewStore.state.items.isEmpty {
                            ProgressView()
                                .frame(width: 120, height: 120, alignment: .center)
                                .onAppear {
                                    viewStore.send(.reachedBottom)
                                }
                        }
                    }
                }
            }
            .navigationBarTitle(LocalizedStringKey("SearchItems"))
            .navigationSearchBar(
                text: viewStore.binding(get: \.searchQuery, send: SearchItemsCore.Action.searchQueryChanged),
                options: [
                    .automaticallyShowsSearchBar: true,
                    .hidesNavigationBarDuringPresentation: true,
                    .hidesSearchBarWhenScrolling: true,
                    .placeholder: "Search the posts",
                ],
                actions: [
                    .onCancelButtonClicked: {
                        log("onCancelButtonClicked")
                    },
                    .onSearchButtonClicked: {
                        viewStore.send(.search)
                    },
                ]
            )
        }
        .navigate(
            using:
            store.scope(
                state: \.webBrowserState,
                action: SearchItemsCore.Action.webBrowser
            ),
            destination: WebBrowserView.init(store:),
            onDismiss: {
                ViewStore(store).send(SearchItemsCore.Action.onDismissWebBrowserView)
            }
        )
    }
}

// MARK: - SearchItemsView_Previews
struct SearchItemsView_Previews: PreviewProvider {

    static var previews: some View {
        SearchItemsView(
            store: .init(
                initialState: .init(
                    searchQuery: "Swift",
                    currentPage: 1,
                    isLoading: false,
                    isLoadingPage: false,
                    items: .mock,
                    webBrowserState: nil
                ),
                reducer: SearchItemsCore()
            )
        )
    }
}
