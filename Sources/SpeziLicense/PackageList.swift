//
// This source file is part of the Stanford Spezi open-source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation
import SwiftPackageList


enum PackageList {
    /// The list of all packages, as returned by `SwiftPackageList`'s API.
    static let spmPackages: [Package] = {
        do {
            let packageProvider = JSONPackageProvider(bundle: .main, fileName: "package-list")
            return try packageProvider.packages()
        } catch {
            print("Failed loading package-list.json: \(error)")
        }
        return []
    }()
}
