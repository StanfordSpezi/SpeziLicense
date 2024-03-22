<!--
                  
This source file is part of the Stanford Spezi open source project

SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)

SPDX-License-Identifier: MIT
             
-->

# SpeziLicense

[![Build and Test](https://github.com/StanfordSpezi/SpeziLicense/actions/workflows/build-and-test.yml/badge.svg)](https://github.com/StanfordSpezi/SpeziLicense/actions/workflows/build-and-test.yml)
[![codecov](https://codecov.io/gh/StanfordBDHG/SwiftPackageTemplate/branch/main/graph/badge.svg?token=X7BQYSUKOH)](https://codecov.io/gh/StanfordBDHG/SwiftPackageTemplate)
[![DOI](https://zenodo.org/badge/573230182.svg)](https://zenodo.org/badge/latestdoi/573230182)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FStanfordBDHG%2FSwiftPackageTemplate%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/StanfordBDHG/SwiftPackageTemplate)


## Setup

### 1. Add Spezi License and Swift Package List as a Dependency

You need to add the SpeziLicense and [SwiftPackageList](https://github.com/FelixHerrmann/swift-package-list) Swift package to
[your app in Xcode](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app#) or
[Swift package](https://developer.apple.com/documentation/xcode/creating-a-standalone-swift-package-with-xcode#Add-a-dependency-on-another-Swift-package).

### 2. Follow the "Run Script Phase" setup steps of the [SwiftPackageList](https://github.com/FelixHerrmann/swift-package-list) documentation.

### 3. Add the SwiftPackageListPlugin to the "Run Build Tool Plug-ins" in your Build Phases settings of your Xcode project.


#### Usage

The code example below showcases how to render a simple list view with all used package dependencies.


```swift
import SpeziLicense
import SwiftUI

struct PackageDependenciesDemoView: View {

    var body: some View {
        ContributionsList()
    }
}
```

## License
This project is licensed under the MIT License. See [Licenses](https://github.com/StanfordBDHG/TemplatePackage/tree/main/LICENSES) for more information.


## Contributors
This project is developed as part of the Stanford Byers Center for Biodesign at Stanford University.
See [CONTRIBUTORS.md](https://github.com/StanfordBDHG/TemplatePackage/tree/main/CONTRIBUTORS.md) for a full list of all TemplatePackage contributors.

![Stanford Byers Center for Biodesign Logo](https://raw.githubusercontent.com/StanfordBDHG/.github/main/assets/biodesign-footer-light.png#gh-light-mode-only)
![Stanford Byers Center for Biodesign Logo](https://raw.githubusercontent.com/StanfordBDHG/.github/main/assets/biodesign-footer-dark.png#gh-dark-mode-only)
