//
//  UsersRequest.swift
//  
//
//  Created by Yuki Okudera on 2022/11/23.
//

import ApiHelper
import Foundation
import Models

public struct UsersRequest: ApiRequestable, Equatable {

    public typealias Response = UsersResponse

    public init(page: Int, perPage: Int = 20) {
        self.page = page
        self.perPage = perPage
    }

    private let page: Int

    private let perPage: Int

    public let path: String = "/api/v2/users"

    public let method: String = "GET"

    public var queryItems: [URLQueryItem]? {
        [
            .init(name: "page", value: "\(self.page)"),
            .init(name: "per_page", value: "\(self.perPage)"),
        ]
    }
}

