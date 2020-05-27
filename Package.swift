// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "PwnedKit",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(
            name: "PwnedTool",
            targets: ["PwnedTool"]
        ),
        .library(
            name: "PwnedKit",
            targets: ["PwnedKit"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pvieito/CommandLineKit.git", .branch("master")),
        .package(url: "https://github.com/pvieito/FoundationKit.git", .branch("master")),
        .package(url: "https://github.com/pvieito/LoggerKit.git", .branch("master")),
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "0.0.6")),
        .package(url: "https://github.com/apple/swift-crypto", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "PwnedTool",
            dependencies: ["LoggerKit", "CommandLineKit", "PwnedKit", .product(name: "ArgumentParser", package: "swift-argument-parser")],
            path: "PwnedTool"
        ),
        .target(
            name: "PwnedKit",
            dependencies: ["FoundationKit", .product(name: "Crypto", package: "swift-crypto")],
            path: "PwnedKit"
        ),
        .testTarget(
            name: "PwnedKitTests",
            dependencies: ["PwnedKit"]
        )
    ]
)
