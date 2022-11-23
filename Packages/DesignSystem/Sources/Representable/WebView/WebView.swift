//
//  WebView.swift
//
//
//  Created by Yuki Okudera on 2022/10/13.
//

import SwiftUI
import WebKit

// MARK: - WebView
public struct WebView: UIViewRepresentable {

    let url: String

    public init(url: String) {
        self.url = url
    }

    public func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    public func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.navigationDelegate = context.coordinator
        guard let url = URL(string: url) else {
            return
        }
        let request = URLRequest(url: url)
        uiView.load(request)
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public class Coordinator: NSObject, WKNavigationDelegate {
        private let parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        public func webView(
            _ webView: WKWebView,
            decidePolicyFor navigationAction: WKNavigationAction,
            decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
        ) {
            guard let scheme = navigationAction.request.url?.scheme else {
                decisionHandler(.cancel)
                return
            }

            switch scheme {
            case "http",
                 "https":
                decisionHandler(.allow)
            default:
                decisionHandler(.cancel)
            }
        }
    }
}

// MARK: - WebView_Previews
struct WebView_Previews: PreviewProvider {

    static var previews: some View {
        WebView(url: "https://www.google.com")
    }
}
