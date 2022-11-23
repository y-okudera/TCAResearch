// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Clients",
    platforms: [
        .macOS(.v11),
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "ItemsApiClient",
            targets: [
                "ItemsApiClient",
            ]
        ),
        .library(
            name: "SearchHistoryClient",
            targets: [
                "SearchHistoryClient",
            ]
        ),
        .library(
            name: "UsersApiClient",
            targets: [
                "UsersApiClient",
            ]
        ),
    ],
    dependencies: [
        // Local
        .package(name: "Logger", path: "../Logger"),
        .package(name: "Models", path: "../Models"),

        // Realm
        .package(url: "https://github.com/realm/realm-swift", exact: "10.32.3"),
        // TCA
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.40.2"),
        .package(url: "https://github.com/pointfreeco/combine-schedulers", from: "0.7.4"),
        .package(url: "https://github.com/pointfreeco/swift-case-paths", from: "0.8.0"),
        .package(url: "https://github.com/pointfreeco/swift-custom-dump", from: "0.3.0"),
        .package(url: "https://github.com/pointfreeco/swift-identified-collections", from: "0.3.2"),
        .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", from: "0.3.2"),
    ],
    targets: [
        .target(
            name: "ApiHelper",
            dependencies: [
                .product(name: "Logger", package: "Logger"),
                .product(name: "Models", package: "Models"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "CasePaths", package: "swift-case-paths"),
                .product(name: "CombineSchedulers", package: "combine-schedulers"),
                .product(name: "CustomDump", package: "swift-custom-dump"),
                .product(name: "IdentifiedCollections", package: "swift-identified-collections"),
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
            ]
        ),
        .target(
            name: "RealmDatabaseClient",
            dependencies: [
                // Local
                .product(name: "Logger", package: "Logger"),
                .product(name: "Models", package: "Models"),
                // Remote
                .product(name: "Realm", package: "realm-swift"),
                .product(name: "RealmSwift", package: "realm-swift"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "CasePaths", package: "swift-case-paths"),
                .product(name: "CombineSchedulers", package: "combine-schedulers"),
                .product(name: "CustomDump", package: "swift-custom-dump"),
                .product(name: "IdentifiedCollections", package: "swift-identified-collections"),
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
            ]
        ),
        .target(
            name: "ItemsApiClient",
            dependencies: [
                // Local
                "ApiHelper",
                .product(name: "Logger", package: "Logger"),
                .product(name: "Models", package: "Models"),
                // Remote
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "CasePaths", package: "swift-case-paths"),
                .product(name: "CombineSchedulers", package: "combine-schedulers"),
                .product(name: "CustomDump", package: "swift-custom-dump"),
                .product(name: "IdentifiedCollections", package: "swift-identified-collections"),
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
            ]
        ),
        .testTarget(
            name: "ItemsApiClientTests",
            dependencies: [
                "ItemsApiClient",
            ]
        ),
        .target(
            name: "SearchHistoryClient",
            dependencies: [
                // Local
                "RealmDatabaseClient",
                .product(name: "Logger", package: "Logger"),
                .product(name: "Models", package: "Models"),
                // Remote
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "CasePaths", package: "swift-case-paths"),
                .product(name: "CombineSchedulers", package: "combine-schedulers"),
                .product(name: "CustomDump", package: "swift-custom-dump"),
                .product(name: "IdentifiedCollections", package: "swift-identified-collections"),
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
            ]
        ),
        .target(
            name: "UsersApiClient",
            dependencies: [
                // Local
                "ApiHelper",
                .product(name: "Logger", package: "Logger"),
                .product(name: "Models", package: "Models"),
                // Remote
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "CasePaths", package: "swift-case-paths"),
                .product(name: "CombineSchedulers", package: "combine-schedulers"),
                .product(name: "CustomDump", package: "swift-custom-dump"),
                .product(name: "IdentifiedCollections", package: "swift-identified-collections"),
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
            ]
        ),
    ]
)
