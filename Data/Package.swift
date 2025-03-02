// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Data",
            targets: ["Data"]),
    ],
    dependencies: [
        .package(path: "../DataInterface"),
        .package(path: "../DomainInterface"),
        .package(path: "../TestUtils")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Data",
            dependencies: [
                .product(name: "DataInterface", package: "DataInterface"),
                .product(name: "DomainInterface", package: "DomainInterface"),
                .product(name: "TestUtils", package: "TestUtils")
            ]
        ),
        .testTarget(
            name: "DataTests",
            dependencies: [
                "Data",
                .product(name: "DataInterface", package: "DataInterface"),
                .product(name: "DomainInterface", package: "DomainInterface"),
            ]
        ),
    ]
)
