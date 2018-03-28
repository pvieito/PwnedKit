// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "PwnedKit",
    products: [
        .executable(name: "PwnedTool", targets: ["PwnedTool"]),
        .library(name: "PwnedKit", targets: ["PwnedKit"])
    ],
    dependencies: [
        .package(url: "../CommandLineKit", .branch("master")),
        .package(url: "../LoggerKit", .branch("master")),
        .package(url: "../CryptoSwift", .branch("master")),
    ],
    targets: [
        .target(name: "PwnedTool",
                dependencies: ["LoggerKit", "CommandLineKit", "PwnedKit"],
                path: "PwnedTool"),
        .target(name: "PwnedKit", dependencies: ["CryptoSwift"], path: "PwnedKit"),
    ]
)
