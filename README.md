<!--
                  
This source file is part of the Stanford Spezi open source project

SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)

SPDX-License-Identifier: MIT
             
-->

# SpeziLicense

[![Build and Test](https://github.com/StanfordSpezi/SpeziLicense/actions/workflows/build-and-test.yml/badge.svg)](https://github.com/StanfordSpezi/SpeziLicense/actions/workflows/build-and-test.yml)


Provides a view that renders a list of all package dependecies used in the project.

| ![Screenshot showing the ContributionsList.](Sources/SpeziLicense/SpeziLicense.docc/Resources/Overview.png#gh-light-mode-only) ![Screenshot showing the ContributionsList.](Sources/SpeziLicense/SpeziLicense.docc/Resources/Overview~dark.png#gh-dark-mode-only) |
 |:---:|
 | A [`ContributionsList`](https://swiftpackageindex.com/stanfordspezi/spezilicense/documentation/spezilicense/contactslist) rendered in the Spezi Template Application. |

## Overview

The Spezi License module provides a quick way to inform users about the tools and packages you have leveraged in your project including their license information.
You use the ``ContributionsList`` abstraction within your views to visualize a list of all Swift package dependecies used in your Xcode project.

This package builds on Felix Hermann's' [SwiftPackageList](https://github.com/FelixHerrmann/swift-package-list) library under the hood.


## Setup

### 1. Add Spezi License and Swift Package List as a Dependency.

You need to add the SpeziLicense and [SwiftPackageList](https://github.com/FelixHerrmann/swift-package-list) Swift package to
[your app in Xcode](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app#) or
[Swift package](https://developer.apple.com/documentation/xcode/creating-a-standalone-swift-package-with-xcode#Add-a-dependency-on-another-Swift-package).

### 2. Add the Run Script Phase to your Xcode Project

Follow the "Run Script Phase" setup steps of the [SwiftPackageList](https://github.com/FelixHerrmann/swift-package-list?tab=readme-ov-file#run-script-phase) documentation.

### 3. Add the SwiftPackageListPlugin to your Xcode Project

Add the SwiftPackageListPlugin to the "Run Build Tool Plug-ins" in your Build Phases settings of your Xcode project as described in the [SwiftPackageList](https://github.com/FelixHerrmann/swift-package-list?tab=readme-ov-file#build-tool-plugin) documentation.


## Example

### Contributions List

The ContributionsList allows you to render a list containing all used Swift packages in your Xcode project including license infromation.
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


## Contributing

Contributions to this project are welcome. Please make sure to read the [contribution guidelines](https://github.com/StanfordSpezi/.github/blob/main/CONTRIBUTING.md) and the [contributor covenant code of conduct](https://github.com/StanfordSpezi/.github/blob/main/CODE_OF_CONDUCT.md) first.


## License

This project is licensed under the MIT License. See [Licenses](https://github.com/StanfordSpezi/Spezi/tree/main/LICENSES) for more information.


![Spezi Footer](https://raw.githubusercontent.com/StanfordSpezi/.github/main/assets/Footer.png#gh-light-mode-only)
![Spezi Footer](https://raw.githubusercontent.com/StanfordSpezi/.github/main/assets/Footer~dark.png#gh-dark-mode-only)
