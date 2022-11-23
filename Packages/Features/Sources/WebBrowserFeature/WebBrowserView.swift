//
//  WebBrowserView.swift
//
//
//  Created by Yuki Okudera on 2022/10/12.
//

import ComposableArchitecture
import Representable
import SwiftUI

// MARK: - WebBrowserView
public struct WebBrowserView: View {

    let store: Store<WebBrowserCore.State, WebBrowserCore.Action>

    public init(store: Store<WebBrowserCore.State, WebBrowserCore.Action>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            WebView(url: viewStore.state.initialUrl)
                .navigationBarTitle(LocalizedStringKey("WebBrowser"))
                .navigationBarTitleDisplayMode(.inline)
                .onAppear { viewStore.send(.onAppear) }
                .onDisappear { viewStore.send(.onDisappear) }
        }
    }
}

// MARK: - WebBrowserView_Previews
struct WebBrowserView_Previews: PreviewProvider {

    static var previews: some View {
        WebBrowserView(
            store: .init(
                initialState: WebBrowserCore.State(initialUrl: ""),
                reducer: WebBrowserCore()
            )
        )
    }
}
