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
    struct Config: Hashable {
        let name: String
        let versionString: String?
        let url: URL?
        let license: License?
        let licenseText: String?
    }
    
    private let config: Config
    
    var body: some View {
        // - if we have the package's license text: the cell is a NavigationLink that shows the license text, and has a button to open the package's web site
        // - if we don't have the text: the cell is a button that directly opens the web site
        // - if we have neither the license text, nor the url: the cell is a button that does nothing.
        if let licenseText = config.licenseText {
            NavigationLink {
                LicenseView(
                    title: config.name,
                    url: config.url,
                    licenseText: licenseText
                )
            } label: {
                rowContent
            }
        } else {
            Button {
                openPackageUrl()
            } label: {
                rowContent
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
    }
    
    private var rowContent: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(config.name)
                        .font(.headline)
                    if let licenseType = config.license {
                        licenseBadge(for: licenseType)
                    }
                }
                if let rule = config.versionString {
                    Text(rule)
                        .font(.caption)
                }
            }
            Spacer()
            if config.licenseText == nil {
                // If we don't have a licence text to push, the row view is not embedded in a NavigationLink,
                // and we need to manually add the disclosure indicator to keep the layout in sync with the surrounding rows.
                DisclosureIndicator()
            }
        }
    }
    
    
    init(config: Config) {
        self.config = config
    }
    
    init(package: Package) {
        config = Config(
            name: package.name,
            versionString: package.dependencyRuleDesc,
            url: URL(string: package.location),
            license: License(package: package),
            licenseText: package.license
        )
    }
    
    private func licenseBadge(for licenseType: License) -> some View {
        Text(licenseType.spdxIdentifier)
            .font(.caption)
            .fontWeight(.semibold)
            .padding(2)
            .background(Color(.systemGray5))
            .cornerRadius(4)
    }
    
    private func openPackageUrl() {
        if let url = config.url {
            UIApplication.shared.open(url)
        }
    }
}


extension Package {
    fileprivate var dependencyRuleDesc: String? {
        if let branch = branch {
            "Branch: \(branch)"
        } else if let version = version {
            "Version: \(version)"
        } else if let revision = revision {
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
