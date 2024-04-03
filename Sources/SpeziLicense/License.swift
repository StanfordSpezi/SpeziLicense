//
// This source file is part of the Stanford Spezi open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation


/// License struct to be passed to `ContributionsList`
public struct License {
    public let name: String
    public let spdxIdentifier: String
    
    /// - Parameters:
    ///   - name: The full name of the License
    ///   - spdxIdentifier: Standardized SPDX-License-Identifier
    public init(name: String, spdxIdentifier: String) {
        self.name = name
        self.spdxIdentifier = spdxIdentifier
    }
}


/// Extensions for some of the most popular licenses
extension License {
    public static let mit = License(name: "MIT License", spdxIdentifier: "MIT")
    
    public static let apachev2 = License(name: "Apache License 2.0", spdxIdentifier: "Apache-2.0")
    
    public static let gplv2only = License(name: "GNU General Public License", spdxIdentifier: "GPL-2.0-only")
    
    public static let gplv2later = License(name: "GNU General Public License version 2.0", spdxIdentifier: "GPL-2.0-or-later")
    
    public static let bsd2 = License(name: "BSD 2-Clause \"Simplified\" License", spdxIdentifier: "BSD-2-Clause")
    
    public static let bsd3 = License(name: "BSD 3-Clause \"New\" or \"Revised\" License", spdxIdentifier: "BSD-3-Clause")
    
    public static let bsd4 = License(name: "BSD 4-Clause \"Original\" or \"Old\" License", spdxIdentifier: "BSD-4-Clause")
    
    public static let zlib = License(name: "zlib License", spdxIdentifier: "Zlib")
}
