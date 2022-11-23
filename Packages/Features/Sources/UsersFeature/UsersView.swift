//
//  UsersView.swift
//  
//
//  Created by Yuki Okudera on 2022/11/23.
//

import Components
import ComposableArchitecture
import FeatureUtils
import Logger
import SwiftUI
import WebBrowserFeature

// MARK: - UsersView
public struct UsersView: View {

    let store: Store<UsersCore.State, UsersCore.Action>

    public init(store: Store<UsersCore.State, UsersCore.Action>) {
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
                        ForEach(viewStore.state.usersResponse ?? [], id: \.id) { user in
                            UserView(user: user)
                                .id(user.id)
                                .onTapGesture { viewStore.send(.onTapUser(user)) }
                        }
                        if !(viewStore.state.usersResponse ?? []).isEmpty {
                            ProgressView()
                                .frame(width: 120, height: 120, alignment: .center)
                                .onAppear { viewStore.send(.reachedBottom) }
                        }
                    }
                }
            }
            .navigationBarTitle(LocalizedStringKey("Users"))
            .onAppear { viewStore.send(.onAppear) }
            .onDisappear { viewStore.send(.onDisappear) }
        }
        .navigate(
            using:
            store.scope(
                state: \.webBrowserState,
                action: UsersCore.Action.webBrowser
            ),
            destination: WebBrowserView.init(store:),
            onDismiss: {
                ViewStore(store).send(UsersCore.Action.onDismissWebBrowserView)
            }
        )
    }
}

// MARK: - UsersView_Previews
struct UsersView_Previews: PreviewProvider {

    static var previews: some View {
        UsersView(
            store: .init(
                initialState: UsersCore.State(),
                reducer: UsersCore()
            )
        )
    }
}
