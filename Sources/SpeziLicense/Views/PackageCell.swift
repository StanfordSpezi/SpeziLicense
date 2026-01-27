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
    struct Config {
        let name: String
        let versionString: String?
        let url: URL?
        let license: License?
        let licenseText: String?
    }
    
    private let config: Config
    
    var body: some View {
        if let licenseText = config.licenseText {
            NavigationLink {
                licenseView(licenseText)
            } label: {
                rowContent
            }
        } else {
            HStack {
                rowContent
                // If the view is not embedded in a NavigationLink, we need to manually add a DisclosureIndicator to the trailing edge, to
                // keep the layout in sync with what we have in the surrounding rows.
                DisclosureIndicator()
            }
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
            if let openPackageUrlButton {
                openPackageUrlButton
                    .buttonStyle(.plain)
                    .foregroundStyle(.blue)
            }
        }
    }
    
    private var openPackageUrlButton: (some View)? {
        if let url = config.url {
            Button("Open in Browser", systemImage: "safari") {
                UIApplication.shared.open(url)
            }
            .labelStyle(.iconOnly)
            .imageScale(.large)
        } else {
            nil
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
    
    private func licenseView(_ text: String) -> some View {
        ScrollView {
            Text(text)
                .padding(.horizontal)
        }
        .navigationTitle(config.name)
        .toolbar {
            if let openPackageUrlButton {
                ToolbarItem(placement: .primaryAction) {
                    openPackageUrlButton
                }
            }
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
