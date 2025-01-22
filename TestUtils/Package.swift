// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TestUtils",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "TestUtils",
            targets: ["TestUtils"]
        ),
    ],
    dependencies: [
        .package(path: "../DataInterface"),
        .package(path: "../DomainInterface"),
    ],
    targets: [
        .target(
            name: "TestUtils",
            dependencies: [
                .product(name: "DataInterface", package: "DataInterface"),
                .product(name: "DomainInterface", package: "DomainInterface"),
            ]
        ),
        .testTarget(
            name: "TestUtilsTests",
            dependencies: ["TestUtils"]),
    ]
)
