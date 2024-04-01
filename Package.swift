// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "ModelIOTool",
    platforms: [
        .macOS(.v13),
    ],
    products: [
        .executable(
            name: "PwnedTool",
            targets: ["PwnedTool"]
        ),
        .library(
            name: "PwnedKit",
            targets: ["PwnedKit"]
        ),
    ],
    dependencies: [
        .package(url: "git@github.com:pvieito/LoggerKit.git", branch: "master"),
        .package(url: "git@github.com:pvieito/FoundationKit.git", branch: "master"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-crypto", from: "1.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "PwnedTool",
            dependencies: [
                "LoggerKit",
                "FoundationKit",
                "PwnedKit",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: "PwnedTool"
        ),
        .target(
            name: "PwnedKit",
            dependencies: [
                "FoundationKit",
                .product(name: "Crypto", package: "swift-crypto"),
            ],
            path: "PwnedKit"
        ),
        .testTarget(
            name: "PwnedKitTests",
            dependencies: ["PwnedKit"]
        ),
    ]
)
