//
//  UsersApiClient.swift
//  
//
//  Created by Yuki Okudera on 2022/11/23.
//

import ApiHelper
import ComposableArchitecture
import Foundation
import Models
import XCTestDynamicOverlay

// MARK: - API client interface

public struct UsersApiClient {

    public var users: @Sendable (UsersRequest) async throws -> UsersRequest.Response
}

extension DependencyValues {

    public var usersApiClient: UsersApiClient {
        get { self[UsersApiClient.self] }
        set { self[UsersApiClient.self] = newValue }
    }
}

extension UsersApiClient: DependencyKey {

    public static let liveValue = UsersApiClient(
        users: { apiRequest in
            guard let urlRequest = apiRequest.urlRequest else {
                throw ApiError.invalidRequest
            }
            let data = try await URLSession.shared.data(for: urlRequest)
            let response = try ApiResponseDecoder.decode(data: data, as: apiRequest)
            return response
        }
    )
}

extension UsersApiClient: TestDependencyKey {

    public static let previewValue = Self(
        users: { _ in .mock }
    )

    public static let testValue = Self(
        users: unimplemented("\(Self.self).users")
    )
}
