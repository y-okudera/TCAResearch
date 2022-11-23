//
//  FavoriteNewsClient.swift
//
//
//  Created by Yuki Okudera on 2022/10/23.
//

import ComposableArchitecture
import Foundation
import Logger
import RealmDatabaseClient
import RealmSwift
import XCTestDynamicOverlay

public struct SearchHistoryClient {

    public var fetchSearchHistory: () async throws -> Results<SearchHistory>
    public var saveSearchHistory: @Sendable (String) async throws -> Void
    public var deleteSearchHistory: @Sendable (String) async throws -> Void
}

extension DependencyValues {

    public var searchHistoryClient: SearchHistoryClient {
        get { self[SearchHistoryClient.self] }
        set { self[SearchHistoryClient.self] = newValue }
    }
}

extension SearchHistoryClient: DependencyKey {

    public static let liveValue = SearchHistoryClient(
        fetchSearchHistory: { try fetch() },
        saveSearchHistory: { query in try save(query) },
        deleteSearchHistory: { query in try delete(query) }
    )

    private static func fetch() throws -> Results<SearchHistory> {
        let realm = try Realm()
        log("\(realm.configuration.description)")
        return realm.fetch(SearchHistory.self)
    }

    private static func save(_ query: String) throws {
        let realm = try Realm()
        log("\(realm.configuration.description)")
        let searchHistory = SearchHistory(
            id: SearchHistory.newId(realm: realm),
            query: query
        )
        try realm.save(searchHistory)
    }

    private static func delete(_ query: String) throws {
        let realm = try Realm()
        log("\(realm.configuration.description)")
        let targetData = realm.objects(SearchHistory.self).filter("query == '\(query)'")
        try realm.write {
            realm.delete(targetData)
        }
    }
}

extension SearchHistoryClient: TestDependencyKey {

    public static let previewValue = Self(
        fetchSearchHistory: { try fetch() },
        saveSearchHistory: { query in try save(query) },
        deleteSearchHistory: { query in try delete(query) }
    )

    public static let testValue = Self(
        fetchSearchHistory: unimplemented("\(Self.self).fetchSearchHistory"),
        saveSearchHistory: unimplemented("\(Self.self).saveSearchHistory"),
        deleteSearchHistory: unimplemented("\(Self.self).deleteSearchHistory")
    )
}
