//
// This source file is part of the Stanford Spezi open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import SwiftPackageList
import SwiftUI


struct PackageCell: View {
    let package: Package
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(package.name).font(.headline)
                HStack {
                    Text(getPackageDetails(package: package))
                        .font(.caption)
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
                    UIApplication.shared.open(package.repositoryURL)
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
    
    
    func getPackageDetails(package: Package) -> String {
        if let branch = package.branch {
            return "Branch: \(branch)"
        } else if let version = package.version {
            return "Version: \(version)"
        } else {
            return "Revision: \(package.revision)"
        }
    }
}


#if DEBUG
#Preview(traits: .sizeThatFitsLayout) {
    let mockPackage = Package(
        identity: "MockPackage",
        name: "MockPackage",
        version: "1.0",
        branch: nil,
        revision: "0",
        // We use a force unwrap in the preview as we can not recover from an error here
        // and the code will never end up in a production environment.
        // swiftlint:disable:next force_unwrapping
        repositoryURL: URL(string: "github.com")!,
        license: "MIT License"
    )
    
    return PackageCell(package: mockPackage)
}
#endif
