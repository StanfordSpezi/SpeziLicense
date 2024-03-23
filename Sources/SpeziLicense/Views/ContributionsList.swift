//
// This source file is part of the Stanford Spezi open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import SwiftPackageList
import SwiftUI


public struct ContributionsList: View {
    var packages: [Package]
    
    
    public var body: some View {
            List {
                Section(footer: Text("This project is licensed under the MIT License.", bundle: .module)) {
                    Text("The following list contains all Swift Package dependencies of the SpeziTemplateApplication.", bundle: .module)
                }
                Section(
                    header: Text("Packages", bundle: .module),
                    footer: Text("Please refer to the individual repository links for packages without license labels.", bundle: .module)
                ) {
                    ForEach(packages.sorted(by: { $0.name < $1.name }), id: \.name) { package in
                        PackageCell(package: package)
                    }
                }
            }
                .navigationTitle("License Information")
                .navigationBarTitleDisplayMode(.inline)
    }
    
    
    public init() {
        self.packages = PackageHelper.getPackageList()
    }
    
    init(packages: [Package]) {
        self.packages = packages
    }
}


#if DEBUG
#Preview {
    let mockPackages = [
        Package(
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
    ]
    return ContributionsList(packages: mockPackages)
}
#endif
