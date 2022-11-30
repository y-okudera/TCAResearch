//
//  Item.swift
//  
//
//  Created by Yuki Okudera on 2022/11/23.
//

import Foundation

public struct Item: Decodable, Equatable, Sendable {

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

    public static func mock(id: String) -> Self {
        let profileImageUrl = URL.localURLForXCAsset(name: "sportman_icon", in: .module)?.absoluteString ?? ""
        return Self(
            coediting: false,
            commentsCount: 0,
            createdAt: "2021-12-07T14:30:22+09:00",
            group: nil,
            id: id,
            likesCount: 12,
            private: false,
            reactionsCount: 0,
            stocksCount: 2,
            tags: [
                .init(
                    name: "AdventCalendar",
                    versions: []
                ),
                .init(
                    name: "iOS",
                    versions: []
                ),
                .init(
                    name: "Swift",
                    versions: []
                ),
                .init(
                    name: "Airdrop",
                    versions: []
                ),
                .init(
                    name: "pokemon",
                    versions: []
                ),
            ],
            title: "長いタイトル長いタイトル長いタイトル長いタイトル長いタイトル",
            updatedAt: "2021-12-07T14:30:22+09:00",
            url: "https://qiita.com/y-okudera/items/0601a59712455a53b8b0",
            user: .init(
                description: nil,
                facebookId: nil,
                followeesCount: 50,
                followersCount: 61,
                githubLoginName: "y-okudera",
                id: "y-okudera",
                itemsCount: 51,
                linkedinId: nil,
                location: "埼玉",
                name: "長い名前長い名前長い名前長い名前長い名前",
                organization: nil,
                permanentId: 103695,
                profileImageUrl: profileImageUrl,
                teamOnly: false,
                twitterScreenName: nil,
                websiteUrl: nil
            ),
            pageViewsCount: 1309,
            teamMembership: nil
        )
    }
}

extension Array where Element == Item {
    public static var mock: Self {
        [
            .mock(id: "1"),
            .mock(id: "2"),
            .mock(id: "3"),
            .mock(id: "4"),
            .mock(id: "5"),
            .mock(id: "6"),
            .mock(id: "7"),
            .mock(id: "8"),
            .mock(id: "9"),
        ]
    }
}
