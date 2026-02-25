//
//  SKList.swift
//  SettingsKitUI
//
//  Created by Haaris Iqubal on 25/02/26.
//

import SwiftUI

// MARK: - Universal List View

/// A cross-platform wrapper around SwiftUI's native `List`.
///
/// `SKList` standardizes the appearance of list-based settings views across different Apple platforms.
/// It automatically applies `.insetGrouped` styling on iOS and hides the scroll content background on macOS
/// to ensure a clean, native look without requiring platform-specific `#if` compiler directives in your app's codebase.
///
/// ### Example Usage
/// ```swift
/// SKList {
///     SKSection(header: { Text("Preferences") }) {
///         SKActionRow(icon: "car", iconColor: .blue, title: "Car", subtitle: "Open Car") {
///             print("Action Triggered")
///         }
///     }
/// }
/// ```
public struct SKList<Content: View>: View {
    
    /// The visual content to be displayed within the list.
    @ViewBuilder public let content: Content
    
    /// Creates a new cross-platform list with the specified content.
    ///
    /// - Parameter content: A view builder closure that provides the sections and rows for the list.
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        List {
            content
        }
        #if os(macOS)
        .scrollContentBackground(.hidden)
        #elseif os(iOS)
        .listStyle(.insetGrouped)
        #endif
    }
}

// MARK: - Previews

#Preview {
    NavigationStack {
        SKList {
            SKSection {
                SKActionRow(
                    icon: "car",
                    iconColor: .accentColor,
                    title: "Car",
                    subtitle: "Open Car",
                    action: {}
                )
            } header: {
                Text("Header")
            } footer : {
                Text("Footer")
            }
        }
        .navigationTitle("Settings Preview")
    }
}
