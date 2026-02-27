//
//  SKPage.swift
//  SettingsKitUI
//
//  Created by Haaris Iqubal on 25/02/26.
//

import SwiftUI

// MARK: Settings Style Enum
public enum SKSettingsStyle : Sendable{
    /// Automatically chooses the best layout according to UI
    case automatic
    /// Forces a Tab-based layout (Toolbar tabs on macOS)
    case tabs
    /// Forces a Sidebar-based layout using NavigationSplitView
    case sidebar
}

// MARK: Environment Setup
private struct SKSettingsStyleKey: EnvironmentKey {
    static let defaultValue: SKSettingsStyle = .automatic
}

public extension EnvironmentValues {
    var skSettingsStyle: SKSettingsStyle {
        get {self[SKSettingsStyleKey.self]}
        set {self[SKSettingsStyleKey.self] = newValue}
    }
}


public extension View {
    /// Sets the layout style for `SKSettingsView`.
    /// - Parameter style: The `SKSettingsStyle` to apply (.tabs or .sidebar).
    func skSettingsStyle(_ style: SKSettingsStyle) -> some View {
        self.environment(\.skSettingsStyle, style)
    }
}

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


