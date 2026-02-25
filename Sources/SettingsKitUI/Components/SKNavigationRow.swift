//
//  SKNavigationRow.swift
//  SettingsKitUI
//
//  Created by Haaris Iqubal on 25/02/26.
//

import SwiftUI

// MARK: - Navigation Row
public struct SKNavigationRow<Destination: View>: View {
    public let icon: String
    public let iconColor: Color
    public let title: String
    public let subtitle: String?
    @ViewBuilder public let destination: Destination
    
    public init(icon: String, iconColor: Color, title: String, subtitle: String? = nil, @ViewBuilder destination: () -> Destination) {
        self.icon = icon
        self.iconColor = iconColor
        self.title = title
        self.subtitle = subtitle
        self.destination = destination()
    }
    
    public var body: some View {
        NavigationLink(destination: destination) {
            SKBaseRow(icon: icon, iconColor: iconColor, title: title, subtitle: subtitle)
        }
    }
}
