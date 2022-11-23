// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DesignSystem",
    platforms: [
        .macOS(.v11),
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "Components",
            targets: [
                "Components",
            ]
        ),
        .library(
            name: "Representable",
            targets: [
                "Representable",
            ]
        ),
    ],
    dependencies: [
        // Local
        .package(name: "Models", path: "../Models"),

        // For downloading and caching images
        .package(url: "https://github.com/onevcat/Kingfisher", from: "7.3.2"),
        .package(url: "https://github.com/JWAutumn/ACarousel", from: "0.2.0"),
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
            name: "Components",
            dependencies: [
                // Local
                .product(name: "Models", package: "Models"),
                // Remote
                .product(name: "Kingfisher", package: "Kingfisher"),
                .product(name: "ACarousel", package: "ACarousel"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "CasePaths", package: "swift-case-paths"),
                .product(name: "CombineSchedulers", package: "combine-schedulers"),
                .product(name: "CustomDump", package: "swift-custom-dump"),
                .product(name: "IdentifiedCollections", package: "swift-identified-collections"),
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
            ]
        ),
        .testTarget(
            name: "ComponentTests",
            dependencies: [
                "Components",
            ]
        ),
        .target(
            name: "Representable",
            dependencies: [
            ]
        ),
        .testTarget(
            name: "RepresentableTests",
            dependencies: [
                "Representable",
            ]
        ),
    ]
)
