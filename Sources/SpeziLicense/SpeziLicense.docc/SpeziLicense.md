# ``SpeziLicense``

<!--
#
# This source file is part of the Stanford Spezi open source project
#
# SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
#
# SPDX-License-Identifier: MIT
#       
-->

Provides a view that renders a list of all package dependecies used in the project.


## Overview

The Spezi License module provides a quick way to inform users about the tools and packages you have leveraged in your project including their license information.
You use the ``ContributionsList`` abstraction within your views to visualize a list of all Swift package dependecies used in your Xcode project.

This package builds on Felix Hermann's' [SwiftPackageList](https://github.com/FelixHerrmann/swift-package-list) library under the hood.


## Setup

### 1. Add Spezi License and Swift Package List as a Dependency.

You need to add the SpeziLicense and [SwiftPackageList](https://github.com/FelixHerrmann/swift-package-list) Swift package to
[your app in Xcode](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app#) or
[Swift package](https://developer.apple.com/documentation/xcode/creating-a-standalone-swift-package-with-xcode#Add-a-dependency-on-another-Swift-package).

### 2. Add the SwiftPackageListPlugin to your Xcode Project

Add the SwiftPackageListPlugin to the "Run Build Tool Plug-ins" in your Build Phases settings of your Xcode project as described in the [SwiftPackageList](https://github.com/FelixHerrmann/swift-package-list?tab=readme-ov-file#build-tool-plugin) documentation.


## Example

### Contributions List

The ContributionsList allows you to render a list containing all used Swift packages in your Xcode project including license infromation.
The code example below showcases how to render a simple list view with all used package dependencies.


```swift
import SpeziLicense
import SwiftUI

struct ExamplePackageDependenciesView: View {

    var body: some View {
        ContributionsList(projectLicense: .mit)
    }
}
```
