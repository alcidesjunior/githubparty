// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Domain",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Domain",
            targets: ["Domain"]),
    ],
    dependencies: [
        .package(path: "../DomainInterface"),
        .package(path: "../Data"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Domain",
            dependencies: [
                .product(name: "DomainInterface", package: "DomainInterface"),
                .product(name: "Data", package: "Data"),
            ]
        ),
        .testTarget(
            name: "DomainTests",
            dependencies: ["Domain"]),
    ]
)
