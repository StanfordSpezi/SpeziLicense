//
// This source file is part of the Stanford Spezi open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation
import SwiftPackageList


enum PackageHelper {
    /// Helper function that calls the corresponding API of `SwiftPackageList`to fetch the list of packages
    static func getPackageList() -> [Package] {
        do {
            let packageProvider = JSONPackageProvider(bundle: .main, fileName: "package-list")
            let packages = try packageProvider.packages()
            
            return packages
        } catch {
            print(error)
        }
        return []
    }
}
