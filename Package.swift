// swift-tools-version:6.0

//
// This source file is part of the Stanford Spezi open-source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import class Foundation.ProcessInfo
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
        .package(url: "https://github.com/FelixHerrmann/swift-package-list.git", from: "4.8.0"),
        .package(url: "https://github.com/StanfordSpezi/Spezi", from: "1.8.2")
    ] + swiftLintPackage(),
    targets: [
        .target(
            name: "SpeziLicense",
            dependencies: [
                .product(name: "SwiftPackageList", package: "swift-package-list")
            ],
            swiftSettings: [.enableUpcomingFeature("ExistentialAny")],
            plugins: [] + swiftLintPlugin()
        ),
        .testTarget(
            name: "SpeziLicenseTests",
            dependencies: [
                .target(name: "SpeziLicense"),
                .product(name: "Spezi", package: "Spezi")
            ],
            swiftSettings: [.enableUpcomingFeature("ExistentialAny")],
            plugins: [] + swiftLintPlugin()
        )
    ]
)


func swiftLintPlugin() -> [Target.PluginUsage] {
    // Fully quit Xcode and open again with `open --env SPEZI_DEVELOPMENT_SWIFTLINT /Applications/Xcode.app`
    if ProcessInfo.processInfo.environment["SPEZI_DEVELOPMENT_SWIFTLINT"] != nil {
        [.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLint")]
    } else {
        []
    }
}

func swiftLintPackage() -> [PackageDescription.Package.Dependency] {
    if ProcessInfo.processInfo.environment["SPEZI_DEVELOPMENT_SWIFTLINT"] != nil {
        [.package(url: "https://github.com/realm/SwiftLint.git", from: "0.59.1")]
    } else {
        []
    }
}
