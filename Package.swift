// swift-tools-version:5.9

//
// This source file is part of the Stanford Spezi open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import PackageDescription


let package = Package(
    name: "SpeziLicense",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "SpeziLicense", targets: ["SpeziLicense"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/FelixHerrmann/swift-package-list.git", from: "4.1.0"
        ),
        .package(url: "https://github.com/StanfordSpezi/Spezi", from: "1.2.0")
    ],
    targets: [
        .target(
            name: "SpeziLicense",
            dependencies: [
                .product(name: "SwiftPackageList", package: "swift-package-list")
            ]
            ,
            plugins: [
                .plugin(name: "SwiftPackageListPlugin", package: "swift-package-list")
            ]
        ),
        .testTarget(
            name: "SpeziLicenseTests",
            dependencies: [
                .target(name: "SpeziLicense"),
                .product(name: "Spezi", package: "Spezi")
            ]
        )
    ]
)
