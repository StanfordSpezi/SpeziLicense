//
// This source file is part of the Stanford Spezi open-source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation
import SwiftPackageList


extension License {
    private static let spdxIdentifierMarker = "SPDX-License-" + "Identifier:"
    // Constants representing typical text and regular expression patterns often found in license files.
    // They are used for matching and identifying different types of licenses within text documents.
    private static let mitText = "MIT License"
    private static let apacheText = "Apache License"
    private static let gnuText = "GNU GENERAL PUBLIC LICENSE"
    private static let bsdTwoClauseText =
        """
        Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met
        """
    private static let bsdThreeClausePattern =
        """
        Neither the name of (.+) nor the names of (.+) may be used to endorse or promote products derived from this software \
        without specific prior written permission
        """
    private static let bsdFourClauseText =
        """
        All advertising materials mentioning features or use of this software must display the following acknowledgement: \
        this product includes software developed by
        """
    private static let zlibPattern =
        """
        The origin of this software must not be misrepresented; you must not claim that you wrote the original software. \
        If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.(.*) \
        Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.(.*) \
        This notice may not be removed or altered from any source distribution.
        """
    private static let supportedLicenses = [
        License.mit,
        .apachev2,
        .gplv2,
        .gplv3,
        .bsd2,
        .bsd3,
        .bsd4,
        .zlib
    ]
    
    
    /// Generates the `LicenseType` from a license document of `String`
    init?(package: Package) {
        guard let licenseText = package.license else {
            return nil
        }

        if let license = Self.licenseFromSPDXIdentifier(in: licenseText) {
            self = license
            return
        }

        let license = licenseText
            .replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)
            .lowercased()
        
        if license.contains(License.mitText.lowercased()) {
            self = .mit
        } else if license.contains(License.apacheText.lowercased()) && license.contains("version 2.0") {
            self = .apachev2
        } else if license.contains(License.gnuText.lowercased()) && license.contains("version 2") {
            self = .gplv2
        } else if license.contains(License.gnuText.lowercased()) && license.contains("version 3") {
            self = .gplv3
        } else if license.contains(License.bsdFourClauseText.lowercased()) {
            self = .bsd4
        } else if license.range(of: License.bsdThreeClausePattern.lowercased(), options: .regularExpression) != nil {
            self = .bsd3
        } else if license.contains(License.bsdTwoClauseText.lowercased()) {
            self = .bsd2
        } else if license.range(of: License.zlibPattern.lowercased(), options: .regularExpression) != nil {
            self = .zlib
        } else {
            return nil
        }
    }

    private static func licenseFromSPDXIdentifier(in text: String) -> License? {
        let identifiers = text
            .components(separatedBy: .newlines)
            .compactMap { line -> String? in
                guard let separator = line.range(of: spdxIdentifierMarker, options: .caseInsensitive) else {
                    return nil
                }
                return line[separator.upperBound...].trimmingCharacters(in: .whitespaces)
            }

        let candidates = identifiers + [text.trimmingCharacters(in: .whitespacesAndNewlines)]
        return supportedLicenses.first { license in
            candidates.contains { $0.caseInsensitiveCompare(license.spdxIdentifier) == .orderedSame }
        }
    }
}
