//
// This source file is part of the Stanford Spezi open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import SwiftPackageList
import SwiftUI


/// Present a `ContributionsList` including all used Swift Packages to the user.
///
/// The following example shows how to use the ContributionsList:
/// ```swift
/// import SpeziLicense
/// import SwiftUI
///
/// struct ExamplePackageDependenciesView: View {
///
///     var body: some View {
///         ContributionsList(appName: "ExamplePackageDependenciesApp", projectLicense: "MIT")
///     }
/// }
/// ```
public struct ContributionsList: View {
    var packages: [Package]
    let appName: String?
    let projectLicense: String?

    
    public var body: some View {
            List {
                Section {
                    if let appName {
                        Text("The following list contains all Swift Package dependencies of the \(appName) app.", bundle: .module)
                    }
                } footer: {
                    if let projectLicense {
                        Text("This project is licensed under the \(projectLicense) License.", bundle: .module)
                    }
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
    
    /// - Parameter projectLicense: Optional SPDX-License-Identifier to inform user about the project's license.
    public init(projectLicense: String? = nil) {
        self.packages = PackageHelper.getPackageList()
        self.appName = Bundle.main.applicationName
        self.projectLicense = projectLicense
    }
    
    /// - Parameters:
    ///   - appName: The name of the app to be rendered in the information text at the top of the view instead of the Display Name configured in the Xcode project.
    ///   - projectLicense: Optional SPDX-License-Identifier to inform user about the project's license.
    public init(appName: String, projectLicense: String? = nil) {
        self.packages = PackageHelper.getPackageList()
        self.appName = appName
        self.projectLicense = projectLicense
    }
    
    init(packages: [Package], appName: String, projectLicense: String? = nil) {
        self.packages = packages
        self.appName = appName
        self.projectLicense = projectLicense
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
    return ContributionsList(packages: mockPackages, appName: "TestApp", projectLicense: "MIT")
}
#endif
