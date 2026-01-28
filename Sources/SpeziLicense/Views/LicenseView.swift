//
// This source file is part of the Stanford Spezi open-source project
//
// SPDX-FileCopyrightText: 2026 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import SwiftPackageList
import SwiftUI


struct LicenseView: View {
    let title: String
    let url: URL?
    let licenseText: String
    
    var body: some View {
        ScrollView {
            Text(licenseText)
                .padding(.horizontal)
        }
        .navigationTitle(title)
        .transforming {
            if #available(iOS 26, *), let subtitle {
                $0.navigationSubtitle(subtitle)
            } else {
                $0
            }
        }
        .toolbar {
            toolbarContent
        }
    }
    
    @ToolbarContentBuilder private var toolbarContent: some ToolbarContent {
        if let url {
            ToolbarItem(placement: .primaryAction) {
                Button("Open in Browser", systemImage: "safari") {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
    
    private var subtitle: String? {
        guard let string = url?.absoluteString else {
            return nil
        }
        let prefixesToRemove = ["https://", "http://"]
        for prefix in prefixesToRemove {
            if let range = string.range(of: prefix), range.lowerBound == string.startIndex {
                return String(string.suffix(from: range.upperBound))
            }
        }
        return string
    }
}


extension View {
    func transforming(@ViewBuilder _ transform: (Self) -> some View) -> some View {
        transform(self)
    }
}
