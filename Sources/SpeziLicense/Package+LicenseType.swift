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
    
    
    /// Generates the `LicenseType` from a license document of `String`
    init?(package: Package) {
        guard let license = package.license?.replacingOccurrences(of: "\\s+|\\n", with: " ", options: .regularExpression) else {
            return nil
        }
        
        if license.contains(License.mitText) {
            self = .mit
        } else if license.contains(License.apacheText) && license.contains("Version 2.0") {
            self = .apachev2
        } else if license.contains(License.gnuText) && license.contains("Version 2") {
            self = .gplv2
        } else if license.contains(License.gnuText) && license.contains("Version 3") {
            self = .gplv3
        } else if license.contains(License.bsdFourClauseText) {
            self = .bsd4
        } else if license.range(of: License.bsdThreeClausePattern, options: .regularExpression) != nil {
            self = .bsd3
        } else if license.contains(License.bsdTwoClauseText) {
            self = .bsd2
        } else if license.range(of: License.zlibPattern, options: .regularExpression) != nil {
            self = .zlib
        } else {
            return nil
        }
    }
}
