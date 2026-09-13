//
// This source file is part of the Stanford Spezi open-source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

@testable import SpeziLicense
import SwiftPackageList
import Testing


@Test("Recognizes known license texts")
func recognizesKnownLicenseTexts() {
    let licenses: [(text: String, expected: License)] = [
        ("MIT License", .mit),
        ("Apache License Version 2.0", .apachev2),
        ("GNU GENERAL PUBLIC LICENSE Version 2", .gplv2),
        ("GNU GENERAL PUBLIC LICENSE Version 3", .gplv3),
        (
            "Redistribution and use in source and binary forms, with or without modification, are permitted provided that "
                + "the following conditions are met",
            .bsd2
        ),
        (
            "Neither the name of Example nor the names of its contributors may be used to endorse or promote products derived from this software "
                + "without specific prior written permission",
            .bsd3
        ),
        (
            "All advertising materials mentioning features or use of this software must display the following acknowledgement: "
                + "this product includes software developed by Example",
            .bsd4
        ),
        (
            "The origin of this software must not be misrepresented; you must not claim that you wrote the original software. "
                + "If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required. "
                + "Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software. "
                + "This notice may not be removed or altered from any source distribution.",
            .zlib
        )
    ]

    for license in licenses {
        #expect(License(package: package(license: license.text)) == license.expected)
    }
}

@Test("Rejects missing and unknown license texts")
func rejectsUnknownLicenseTexts() {
    #expect(License(package: package(license: nil)) == nil)
    #expect(License(package: package(license: "A proprietary license")) == nil)
}


private func package(license: String?) -> Package {
    Package(
        kind: .remoteSourceControl,
        identity: "example",
        name: "Example",
        version: "1.0.0",
        branch: nil,
        revision: nil,
        location: "https://example.com/example.git",
        license: license
    )
}
