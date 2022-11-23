// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [
        .macOS(.v11),
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "AppFeature",
            targets: [
                "AppFeature",
            ]
        ),
    ],
    dependencies: [
        // Local
        .package(name: "Logger", path: "../Logger"),
        .package(name: "Clients", path: "../Clients"),
        .package(name: "DesignSystem", path: "../DesignSystem"),

        // An extension to SwiftUI that will add the UISearchController.
        .package(url: "https://github.com/markvanwijnen/NavigationSearchBar.git", from: "1.3.0"),

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
            name: "AppFeature",
            dependencies: [
                // Local
                "UsersFeature",
                "SearchItemsFeature",
                "WebBrowserFeature",
                .product(name: "ItemsApiClient", package: "Clients"),
                .product(name: "UsersApiClient", package: "Clients"),
                // Remote
                // TCA
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "CasePaths", package: "swift-case-paths"),
                .product(name: "CombineSchedulers", package: "combine-schedulers"),
                .product(name: "CustomDump", package: "swift-custom-dump"),
                .product(name: "IdentifiedCollections", package: "swift-identified-collections"),
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
            ]
        ),
        .testTarget(
            name: "AppFeatureTests",
            dependencies: [
                "AppFeature",
            ]
        ),
        .target(
            name: "FeatureUtils",
            dependencies: [
                // Local
                .product(name: "Logger", package: "Logger"),
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
            name: "FeatureUtilTests",
            dependencies: [
                "FeatureUtils",
            ]
        ),
        .target(
            name: "UsersFeature",
            dependencies: [
                // Local
                "WebBrowserFeature",
                .product(name: "Components", package: "DesignSystem"),
                .product(name: "UsersApiClient", package: "Clients"),
            ]
        ),
        .target(
            name: "SearchItemsFeature",
            dependencies: [
                // Local
                "WebBrowserFeature",
                .product(name: "Components", package: "DesignSystem"),
                .product(name: "ItemsApiClient", package: "Clients"),
                .product(name: "SearchHistoryClient", package: "Clients"),
                // NavigationSearchBar
                .product(name: "NavigationSearchBar", package: "NavigationSearchBar"),
            ]
        ),
        .testTarget(
            name: "SearchItemsFeatureTests",
            dependencies: [
                "SearchItemsFeature",
            ]
        ),
        .target(
            name: "WebBrowserFeature",
            dependencies: [
                // Local
                "FeatureUtils",
                .product(name: "Representable", package: "DesignSystem"),
            ]
        ),
        .testTarget(
            name: "WebBrowserFeatureTests",
            dependencies: [
                "WebBrowserFeature",
            ]
        ),
    ]
)
