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
    public let systemIcon: String
    public let view: AnyView
    
    /// Creates a new settings pages.
    /// - Parameters:
    ///    - title: The display name of the page
    ///    - systemIcon: The SF Symbol name for the page icon
    ///    - content: The view to display (usually an `SKList`).
    public init<V: View>(title: String, systemIcon: String, @ViewBuilder content: () -> V) {
        self.id = title
        self.title = title
        self.systemIcon = systemIcon
        self.view = AnyView(content())
    }
}


