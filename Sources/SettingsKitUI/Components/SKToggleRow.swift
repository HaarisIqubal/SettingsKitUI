//
//  SKToggleRow.swift
//  SettingsKitUI
//
//  Created by Haaris Iqubal on 25/02/26.
//

import SwiftUI

// MARK: Toggle Row

/// A view that presents a toggle switch alongside an icon, title, and optional subtitle, utilizing the `SKBaseRow` layout.
///
/// Use `SKToggleRow` to create consistent settings or preference rows where users can turn options on or off.
/// It automatically hides the default toggle label to integrate seamlessly with the custom row layout.
///
/// ### Basic Example
/// ```swift
/// @State private var notificationsEnabled = true
///
/// var body: some View {
///     SKToggleRow(
///         icon: "bell.fill",
///         iconColor: .red,
///         title: "Notifications",
///         isOn: $notificationsEnabled
///     )
/// }
/// ```
public struct SKToggleRow: View {
    
    // MARK: Properties
    
    /// The name of the SF Symbol or image asset to display as the row's icon.
    public let icon: String
    
    /// The color used to tint the icon's background or foreground.
    public let iconColor: Color
    
    /// The primary text displayed in the row.
    public let title: String
    
    /// The secondary text displayed beneath the title. This property is optional.
    public let subtitle: String?
    
    /// A binding to a boolean property that determines whether the toggle is on or off.
    @Binding public var isOn: Bool
    
    // MARK: Initialization
    
    /// Creates a new toggle row with an icon, tint color, title, optional subtitle, and a state binding.
    ///
    /// - Parameters:
    ///   - icon: A string representing the image or SF Symbol name.
    ///   - iconColor: The color used to tint the icon.
    ///   - title: The primary text to display.
    ///   - subtitle: The optional secondary text to display. Defaults to `nil`.
    ///   - isOn: A binding to a boolean value that dictates the toggle's state.
    public init(icon: String, iconColor: Color, title: String, subtitle: String? = nil, isOn: Binding<Bool>) {
        self.icon = icon
        self.iconColor = iconColor
        self.title = title
        self.subtitle = subtitle
        self._isOn = isOn
    }
    
    // MARK: Body
    
    /// The content and layout of the toggle row.
    public var body: some View {
        SKBaseRow(icon: icon, iconColor: iconColor, title: title, subtitle: subtitle) {
            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
    }
}

//MARK: Preview

#Preview {
    @Previewable @State var location = false
    SKToggleRow(icon: "location.fill", iconColor: .blue, title: "Location", isOn: $location)
}
