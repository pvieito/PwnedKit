// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "PwnedKit",
    products: [
        .executable(name: "PwnedTool", targets: ["PwnedTool"]),
        .library(name: "PwnedKit", targets: ["PwnedKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/pvieito/CommandLineKit.git", .branch("master")),
        .package(url: "https://github.com/pvieito/LoggerKit.git", .branch("master")),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", .branch("master")),
    ],
    targets: [
        .target(name: "PwnedTool", dependencies: ["LoggerKit", "CommandLineKit", "PwnedKit"], path: "PwnedTool"),
        .target(name: "PwnedKit", dependencies: ["CryptoSwift"], path: "PwnedKit"),
    ]
)
