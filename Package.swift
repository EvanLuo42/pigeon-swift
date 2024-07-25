// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Pigeon",
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.1.0"),
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.27.0"),
        .package(url: "https://github.com/fireblade-engine/ecs.git", from: "0.17.4")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "Pigeon",
            dependencies: [
                .product(name: "NIO", package: "swift-nio"),
                .product(name: "SwiftProtobuf", package: "swift-protobuf"),
                .product(name: "FirebladeECS", package: "ecs")
            ])
    ]
)
