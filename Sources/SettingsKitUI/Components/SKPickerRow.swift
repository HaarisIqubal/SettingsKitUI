//
//  SKPickerRow.swift
//  SettingsKitUI
//
//  Created by Haaris Iqubal on 27/02/26.
//

import SwiftUI
import SwiftUI

// MARK: Picker Row

/// A customizable picker view that can adopt either a standard system appearance or a custom `SKBaseRow` layout.
///
/// Use `SKPickerRow` to present a selection of mutually exclusive options. Depending on the initializer you choose,
/// this component can render as a standard SwiftUI `Picker` or as an enhanced row displaying an icon and subtitle.
///
/// ### Basic Example
/// ```swift
/// SKPickerRow(title: "Theme", selection: $themeSelection) {
///     Text("Light").tag(0)
///     Text("Dark").tag(1)
/// }
/// ```
///
/// ### Advanced Example
/// ```swift
/// SKPickerRow(
///     icon: "paintpalette.fill",
///     iconColor: .indigo,
///     title: "Accent Color",
///     subtitle: "Choose your primary app color",
///     selection: $colorSelection
/// ) {
///     Text("Blue").tag(Color.blue)
///     Text("Red").tag(Color.red)
/// }
/// ```
public struct SKPickerRow<SelectionValue: Hashable, Content: View>: View {
    
    // MARK: Properties
    
    /// The primary text to display for the picker.
    public let title: String
    
    /// The secondary text displayed beneath the title. Only applicable when using the `SKBaseRow` style.
    public let subtitle: String?
    
    /// The name of the SF Symbol or image asset to display as the row's icon.
    public let icon: String?
    
    /// The color used to tint the icon's background.
    public let iconColor: Color?
    
    /// A binding to a property that determines the currently selected option.
    @Binding public var selection: SelectionValue
    
    /// A view builder that creates the content of the picker, typically consisting of views with `.tag()` modifiers.
    @ViewBuilder public var content: Content
    
    // MARK: - Initialization
    
    /// Creates a picker view wrapped inside an `SKBaseRow` layout.
    ///
    /// Use this initializer when you want to display a picker alongside an icon and an optional subtitle.
    ///
    /// - Parameters:
    ///     - icon: The SF Symbol name or image asset string.
    ///     - iconColor: The background color of the icon.
    ///     - title: The primary label text.
    ///     - subtitle: The secondary label text. Defaults to `nil`.
    ///     - selection: A binding to the currently selected value.
    ///     - content: A view builder returning the picker's options (using the `.tag()` modifier).
    public init(
        icon: String,
        iconColor: Color,
        title: String,
        subtitle: String? = nil,
        selection: Binding<SelectionValue>,
        @ViewBuilder content: () -> Content
    ) {
        self.icon = icon
        self.iconColor = iconColor
        self.title = title
        self.subtitle = subtitle
        self._selection = selection
        self.content = content()
    }
    
    /// Creates a standard picker row without the `SKBaseRow` layout.
    ///
    /// Use this initializer for a standard system-styled picker that only requires a title.
    ///
    /// - Parameters:
    ///     - title: The primary label text.
    ///     - selection: A binding to the currently selected value.
    ///     - content: A view builder returning the picker's options (using the `.tag()` modifier).
    public init(
        title: String,
        selection: Binding<SelectionValue>,
        @ViewBuilder content: () -> Content
    ) {
        self.icon = nil
        self.iconColor = nil
        self.subtitle = nil
        self.title = title
        self._selection = selection
        self.content = content()
    }
    
    // MARK: Body
    
    /// The content and behavior of the picker row.
    public var body: some View {
        if let icon = icon, let iconColor = iconColor {
            SKBaseRow(icon: icon, iconColor: iconColor, title: title, subtitle: subtitle) {
                Picker("", selection: $selection) {
                    content
                }
                .labelsHidden()
            }
        }
        else {
            Picker(title, selection: $selection) {
                content
            }
        }
    }
}

// MARK: Previews

#Preview {
    @Previewable @State var selectionMethod = 1
    SKPickerRow(title: "Calculation method", selection: $selectionMethod) {
        Text("2")
            .tag(2)
    }
    #if os(macOS)
    .pickerStyle(.radioGroup)
    .frame(minWidth: 120)
    #endif
    .labelsHidden()
}
