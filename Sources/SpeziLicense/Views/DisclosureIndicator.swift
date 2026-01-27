//
// This source file is part of the Stanford Spezi open-source project
//
// SPDX-FileCopyrightText: 2026 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


struct DisclosureIndicator: View {
    var body: some View {
        Image(systemName: "chevron.forward")
            .accessibilityHidden(true)
            .symbolRenderingMode(.monochrome)
            .foregroundStyle(.tertiary)
            .font(.body.bold())
            .imageScale(.small)
    }
}
