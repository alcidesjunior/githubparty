// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HomeModule",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "HomeModule",
            targets: ["HomeModule"]),
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "8.1.3"),
        .package(path: "../Utils"),
        .package(path: "../Domain"),
    ],
    targets: [
        .target(
            name: "HomeModule",
            dependencies: [
                .product(name: "Utils", package: "Utils"),
                .product(name: "Domain", package: "Domain"),
                "Kingfisher"
            ]
        ),
        .testTarget(
            name: "HomeModuleTests",
            dependencies: ["HomeModule"]),
    ]
)
