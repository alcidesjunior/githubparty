// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataInterface",
    products: [
        .library(
            name: "DataInterface",
            targets: ["DataInterface"]),
    ],
    dependencies: [
        .package(path: "../DomainInterface")
    ],
    targets: [
        .target(
            name: "DataInterface",
            dependencies: [.product(name: "DomainInterface", package: "DomainInterface")]),
        .testTarget(
            name: "DataInterfaceTests",
            dependencies: ["DataInterface"]),
    ]
)
