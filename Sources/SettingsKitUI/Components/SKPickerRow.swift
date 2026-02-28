//
//  SKPickerRow.swift
//  SettingsKitUI
//
//  Created by Haaris Iqubal on 27/02/26.
//

import SwiftUI

public struct SKPickerRow<SelectionValue: Hashable, Content: View>: View {
    public let title:String
    public let subtitle: String?
    public let icon: String?
    public let iconColor: Color?
    
    @Binding public var selection: SelectionValue
    @ViewBuilder public var content: Content
    
    //MARK: Initialiser 1 - Picker wrap around `SKBaseRow`
    /// Creates a picker view wraps around `SKBaseRow`
    ///
    /// - Parameters:
    ///     - icon: The SF Symbol name.
    ///     - iconColor: The background color of the icon
    ///     - title: The primary label text.
    ///     - subtitle: The secondary label text.
    ///     - selection: A binding of selection value.
    ///     - content: The picker rest view as per user (using `.tag()`.
    public init(icon: String,
                iconColor: Color,
                title:String,
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
    
    //MARK: Initialiser 2 - Only picker style
    /// Creates a normal picker row without adding `SKBaseRow` layout.
    ///
    /// - Parameters:
    ///     - title: The primary label text.
    ///     - selection: A binding of selection value.
    ///     - content: The picker rest view as per user (using `.tag()`.
    public init(title: String, selection: Binding<SelectionValue>, content: () -> Content) {
        self.icon = nil
        self.iconColor = nil
        self.subtitle = nil
        self.title = title
        self._selection = selection
        self.content = content()
    }
    
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
