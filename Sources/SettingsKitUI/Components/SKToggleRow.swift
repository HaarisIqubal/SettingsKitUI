//
//  SKToggleRow.swift
//  SettingsKitUI
//
//  Created by Haaris Iqubal on 25/02/26.
//

import SwiftUI

// MARK: - Toggle Row
public struct SettingsToggleRow: View {
    public let icon: String
    public let iconColor: Color
    public let title: String
    public let subtitle: String?
    @Binding public var isOn: Bool
    
    public init(icon: String, iconColor: Color, title: String, subtitle: String? = nil, isOn: Binding<Bool>) {
        self.icon = icon
        self.iconColor = iconColor
        self.title = title
        self.subtitle = subtitle
        self._isOn = isOn
    }
    
    public var body: some View {
        SKBaseRow(icon: icon, iconColor: iconColor, title: title, subtitle: subtitle) {
            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
    }
}
