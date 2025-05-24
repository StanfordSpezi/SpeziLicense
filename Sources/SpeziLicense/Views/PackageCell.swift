//
// This source file is part of the Stanford Spezi open-source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import OSLog
import SwiftPackageList
import SwiftUI


struct PackageCell: View {
    let package: Package
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(package.name).font(.headline)
                HStack {
                    if let details = getPackageDetails(package: package) {
                        Text(details)
                            .font(.caption)
                    }
                    if let licenseType = License(package: package) {
                        Text(licenseType.spdxIdentifier)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(2)
                            .background(Color(.systemGray5))
                            .cornerRadius(4)
                    }
                }
            }
            Spacer()
            Button(
                action: {
                    if let url = URL(string: package.location) {
                        UIApplication.shared.open(url)
                    } else {
                        let logger = Logger(subsystem: "edu.stanford.spezi.SpeziLicense", category: "UI")
                        logger.error("Unable to parse package location into URL: '\(package.location)'")
                    }
                },
                label: {
                    Image(systemName: "safari.fill")
                        .imageScale(.large)
                }
            )
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.blue)
                .accessibilityLabel(Text("Repository Link"))
        }
    }
    
    
    func getPackageDetails(package: Package) -> String? {
        if let branch = package.branch {
            "Branch: \(branch)"
        } else if let version = package.version {
            "Version: \(version)"
        } else if let revision = package.revision {
            "Revision: \(revision)"
        } else {
            nil
        }
    }
}


#if DEBUG
#Preview(traits: .sizeThatFitsLayout) {
    let mockPackage = Package(
        kind: .remoteSourceControl,
        identity: "MockPackage",
        name: "MockPackage",
        version: "1.0",
        branch: nil,
        revision: "0",
        location: "https://github.com/StanfordSpezi/MockPackage.git",
        license: "MIT License"
    )
    
    return PackageCell(package: mockPackage)
}
#endif
