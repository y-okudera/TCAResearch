//
//  SearchFeatureTests.swift
//
//
//  Created by Yuki Okudera on 2022/10/16.
//

import ComposableArchitecture
@testable import SearchItemsFeature
import SnapshotTesting
import TestHelper
import XCTest
import SwiftUI

final class SearchFeatureTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        isRecording = true
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchItemsView() throws {
        XCTContext.runActivity(named: "itemsが空ではない") { _ in
            let store = Store(
                initialState: SearchItemsCore.State(),
                reducer: SearchItemsCore()
            )
            SnapshotDevices.allCases.forEach {

                let view = SearchItemsView(
                    store: store
                )
                let viewStore = ViewStore(store)
                viewStore.send(.itemsResult(.success(.mock)))

                assertSnapshot(
                    matching: view,
                    as: .image(layout: $0.layout),
                    named: "itemsが空ではない.\($0.rawValue)"
                )
            }
        }
    }
}
