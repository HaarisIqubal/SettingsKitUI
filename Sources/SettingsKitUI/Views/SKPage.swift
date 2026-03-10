//
//  SKPage.swift
//  SettingsKitUI
//
//  Created by Haaris Iqubal on 25/02/26.
//

import SwiftUI

// MARK: Page Model
/// Represents a single Settings screen (a tab or a sidebar item).
public struct SKPage: Identifiable {
    public let id: String
    public let title:String
    public let icon: SKIcon
    public let view: AnyView
    
    /// Creates a new settings pages.
    /// - Parameters:
    ///    - title: The display name of the page
    ///    - icon: The SF Symbol name for the page icon
    ///    - content: The view to display (usually an `SKList`).
    public init<V: View>(
        title: String,
        icon: SKIcon,
        @ViewBuilder content: () -> V) {
        self.id = title
        self.title = title
        self.icon = icon
        self.view = AnyView(content())
    }
}


