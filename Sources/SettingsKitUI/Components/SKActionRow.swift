//
//  SKActionRow.swift
//  SettingsKitUI
//
//  Created by Haaris Iqubal on 25/02/26.
//

import SwiftUI

import SwiftUI

// MARK: - Action / Button Row

/// A view that acts as an action button by wrapping a native SwiftUI `Button` around an `SKBaseRow`.
///
/// `SKActionRow` provides a basic interactive row containing an icon, a title, an optional subtitle, and a closure that executes when tapped.
/// It utilizes a plain button style, ensuring that the visual styling is entirely handled by the underlying `SKBaseRow` component.
/// /// ### Example Usage
/// #### Basic example
/// ```swift
/// SKActionRow(icon: "cloud.fill", iconColor: .blue, title: "iCloud", action: {
/// self.icloudKey.toggle()
///})
/// ```
public struct SKActionRow: View {
    
    // MARK: - Properties
    
    /// The name of the image asset or SF Symbol used for the row's icon.
    public let icon: String
    
    /// The tint color applied to the icon.
    public let iconColor: Color
    
    /// The primary text displayed in the row.
    public let title: String
    
    /// The secondary text displayed beneath the title. This value is optional.
    public let subtitle: String?
    
    /// The closure to execute when the user taps the row.
    public let action: () -> Void
    
    // MARK: - Initialization
    
    /// Creates a new action row with a specified icon, title, optional subtitle, and an action.
    ///
    /// - Parameters:
    ///   - icon: A `String` representing the icon to display.
    ///   - iconColor: The `Color` used to tint the icon.
    ///   - title: The primary text to display.
    ///   - subtitle: Optional secondary text to display below the title. Defaults to `nil`.
    ///   - action: The closure to invoke when the row is tapped.
    public init(icon: String, iconColor: Color, title: String, subtitle: String? = nil, action: @escaping () -> Void) {
        self.icon = icon
        self.iconColor = iconColor
        self.title = title
        self.subtitle = subtitle
        self.action = action
    }
    
    // MARK: - Body
    
    public var body: some View {
        Button(action: action) {
            SKBaseRow(icon: icon, iconColor: iconColor, title: title, subtitle: subtitle)
        }
        .buttonStyle(.plain)
    }
}
