//
//  SKSection.swift
//  SettingsKitUI
//
//  Created by Haaris Iqubal on 25/02/26.
//

import SwiftUI

// MARK: - Universal Section View

/// A cross-platform wrapper around SwiftUI's native `Section`.
///
/// `SKSection` is designed to logically group your settings rows (like toggles, actions, and links)
/// inside an `SKList`. It provides a clean, unified initializer that allows you to optionally
/// provide a header and a footer without needing multiple initializer overrides.
///
/// ### Example Usage
/// ```swift
/// SKSection {
///     // Your rows go here
///     SKActionRow(icon: "bell", iconColor: .red, title: "Notifications", action: {})
/// } header: {
///     Text("Preferences")
/// } footer: {
///     Text("Adjust your notification settings here.")
/// }
/// ```
///
/// If you don't need a header or footer, you can simply omit them:
/// ```swift
/// SKSection {
///     SKActionRow(icon: "star", iconColor: .yellow, title: "Rate App", action: {})
/// }
/// ```
public struct SKSection<Content: View, Header: View, Footer: View>: View {
    
    /// The visual content to be displayed within the section (usually rows).
    @ViewBuilder public let content: Content
    
    /// The view to display at the top of the section.
    @ViewBuilder public let header: Header
    
    /// The view to display at the bottom of the section.
    @ViewBuilder public let footer: Footer
    
    /// Creates a new cross-platform section with the specified content, header, and footer.
    ///
    /// - Parameters:
    ///   - content: A view builder closure that provides the rows for this section.
    ///   - header: A view builder closure that provides the header view. Defaults to `EmptyView`.
    ///   - footer: A view builder closure that provides the footer view. Defaults to `EmptyView`.
    public init(
        @ViewBuilder content: () -> Content,
        @ViewBuilder header: () -> Header = { EmptyView() },
        @ViewBuilder footer: () -> Footer = { EmptyView() }
    ) {
        self.content = content()
        self.header = header()
        self.footer = footer()
    }
    
    public var body: some View {
        Section(
            content: { content },
            header: { header },
            footer: { footer }
        )
    }
}
