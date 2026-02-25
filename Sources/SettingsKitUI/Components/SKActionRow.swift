//
//  SKActionRow.swift
//  SettingsKitUI
//
//  Created by Haaris Iqubal on 25/02/26.
//

import SwiftUI

// MARK: - Action / Button Row
public struct SKActionRow: View {
    public let icon: String
    public let iconColor: Color
    public let title: String
    public let subtitle: String?
    public let action: () -> Void
    
    public init(icon: String, iconColor: Color, title: String, subtitle: String? = nil, action: @escaping () -> Void) {
        self.icon = icon
        self.iconColor = iconColor
        self.title = title
        self.subtitle = subtitle
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            SKBaseRow(icon: icon, iconColor: iconColor, title: title, subtitle: subtitle)
        }
        .buttonStyle(.plain)
    }
}
