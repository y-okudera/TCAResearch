//
//  AppView.swift
//
//
//  Created by Yuki Okudera on 2022/10/10.
//

import ComposableArchitecture
import UsersFeature
import SearchItemsFeature
import SwiftUI

// MARK: - AppView
public struct AppView: View {

    let store: Store<AppCore.State, AppCore.Action>

    public init(store: Store<AppCore.State, AppCore.Action>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            TabView(
                selection: viewStore.binding(
                    get: { $0.selectedTab },
                    send: AppCore.Action.selectedTabChange
                ),
                content: {
                    NavigationView {
                        UsersView(
                            store: .init(
                                initialState: .init(),
                                reducer: UsersCore()
                            )
                        )
                    }
                    .tabItem {
                        Image(systemName: "house")
                        Text(LocalizedStringKey("Users"))
                    }
                    .tag(AppCore.State.Tab.users)

                    NavigationView {
                        SearchItemsView(
                            store: .init(
                                initialState: .init(),
                                reducer: SearchItemsCore()
                            )
                        )
                    }
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text(LocalizedStringKey("Search"))
                    }
                    .tag(AppCore.State.Tab.search)
                }
            )
        }
    }
}

// MARK: - AppView_Previews
struct AppView_Previews: PreviewProvider {

    static var previews: some View {
        AppView(
            store: .init(
                initialState: AppCore.State(appDelegateState: .init()),
                reducer: AppCore()
            )
        )
    }
}
