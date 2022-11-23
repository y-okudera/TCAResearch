//
//  Item.swift
//  
//
//  Created by Yuki Okudera on 2022/11/23.
//

import Foundation

public struct Item: Decodable, Equatable, Sendable {

    public let renderedBody: String
    public let body: String
    public let coediting: Bool
    public let commentsCount: Int
    public let createdAt: String?
    public let group: Group?
    public let id: String
    public let likesCount: Int
    public let `private`: Bool
    public let reactionsCount: Int
    public let stocksCount: Int
    public let tags: [Tag]
    public let title: String
    public let updatedAt: String?
    public let url: String
    public let user: User
    public let pageViewsCount: Int?
    public let teamMembership: TeamMembership?
}

// MARK: - Group
public struct Group: Decodable, Equatable, Sendable {

    public let createdAt: String?
    public let description: String
    public let name: String
    public let `private`: Bool
    public let updatedAt: String?
    public let urlName: String
}

// MARK: - Tag
public struct Tag: Decodable, Equatable, Sendable {

    public let name: String
    public let versions: [String]
}

// MARK: - TeamMembership
public struct TeamMembership: Decodable, Equatable, Sendable {

    public let name: String
}

// MARK: - Mock
extension Item {
    public static var mock: Self {
        .init(
            renderedBody: "<h1>Example</h1>",
            body: "# Example",
            coediting: false,
            commentsCount: 100,
            createdAt: "2000-01-01",
            group: .init(
                createdAt: "2000-01-01",
                description: "This group is for developers.",
                name: "Dev",
                private: false,
                updatedAt: "2000-01-01",
                urlName: "dev"
            ),
            id: "c686397e4a0f4f11683d",
            likesCount: 100,
            private: false,
            reactionsCount: 100,
            stocksCount: 100,
            tags: [
                .init(
                    name: "Ruby",
                    versions: [
                        "0.0.1",
                    ]
                )
            ],
            title: "Example title",
            updatedAt: "2000-01-01",
            url: "https://qiita.com/Qiita/items/c686397e4a0f4f11683d",
            user: .mock,
            pageViewsCount: 100,
            teamMembership: .init(
                name: "Qiita キータ"
            )
        )
    }
}

extension Array where Element == Item {
    public static var mock: Self {
        [
            .mock,
        ]
    }
}
