//
//  FavoriteNews.swift
//
//
//  Created by Yuki Okudera on 2022/10/23.
//

import Foundation
import Models
import RealmSwift

// MARK: - SearchHistory
public final class SearchHistory: Object {

    static func newId(realm: Realm) -> Int {
        if let searchHistory = realm.objects(Self.self).sorted(byKeyPath: "id").last {
            return searchHistory.id + 1
        } else {
            return 1
        }
    }

    @Persisted(primaryKey: true) public var id: Int
    @Persisted public var query: String

    /// Standalone objectのイニシャライザ
    public convenience init(
        id: Int,
        query: String
    ) {
        self.init()
        self.id = id
        self.query = query
    }
}

// MARK: - Mock
extension SearchHistory {
    public static var mock: Self {
        .init(
            id: 0,
            query: "python"
        )
    }
}
