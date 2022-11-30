//
//  SearchFeatureTests.swift
//
//
//  Created by Yuki Okudera on 2022/10/16.
//

import ComposableArchitecture
@testable import SearchItemsFeature
import SnapshotTesting
import SwiftUI
import TestHelper
import XCTest

final class SearchFeatureTests: XCTestCase {

    override func setUp() {
        // 全て新しくSnapshotを撮る場合は、trueにします
//        isRecording = true
    }

    override func tearDown() {}

    func testSearchItemsView() throws {
        XCTContext.runActivity(named: "itemsが空ではない") { _ in
            let store = Store(
                initialState: .init(
                    searchQuery: "長い検索語長い検索語長い検索語長い検索語長い検索語",
                    currentPage: 1,
                    isLoading: false,
                    isLoadingPage: false,
                    items: .mock,
                    webBrowserState: nil
                ),
                reducer: SearchItemsCore()
            )
            let view = NavigationView {
                SearchItemsView(
                    store: store
                )
            }
            SnapshotDevices.allCases.forEach {
                assertSnapshot(
                    matching: view,
                    as: .image(layout: $0.layout),
                    named: "itemsが空ではない.\($0.rawValue)"
                )
            }
        }
    }
}
