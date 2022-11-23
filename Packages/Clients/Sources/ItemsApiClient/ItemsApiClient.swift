//
//  ItemsApiClient.swift
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

public struct ItemsApiClient {

    public var items: @Sendable (ItemsRequest) async throws -> ItemsRequest.Response
}

extension DependencyValues {

    public var itemsApiClient: ItemsApiClient {
        get { self[ItemsApiClient.self] }
        set { self[ItemsApiClient.self] = newValue }
    }
}

extension ItemsApiClient: DependencyKey {

    public static let liveValue = ItemsApiClient(
        items: { apiRequest in
            guard let urlRequest = apiRequest.urlRequest else {
                throw ApiError.invalidRequest
            }
            let data = try await URLSession.shared.data(for: urlRequest)
            let response = try ApiResponseDecoder.decode(data: data, as: apiRequest)
            return response
        }
    )
}

extension ItemsApiClient: TestDependencyKey {

    public static let previewValue = Self(
        items: { _ in .mock }
    )

    public static let testValue = Self(
        items: unimplemented("\(Self.self).items")
    )
}
