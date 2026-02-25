//
//  SKBaseRow.swift
//  SettingsKitUI
//
//  Created by Haaris Iqubal on 25/02/26.
//

import SwiftUI

public struct SKBaseRow<TrailingContent: View>: View {
    public let icon: String
    public let iconColor: Color
    public let title: String
    public let subtitle: String?
    @ViewBuilder public let trailingContent: TrailingContent
    
    public init(
        icon: String,
        iconColor: Color,
        title: String,
        subtitle: String? = nil,
        @ViewBuilder trailingContent: () -> TrailingContent = { EmptyView() }
    ) {
        self.icon = icon
        self.iconColor = iconColor
        self.title = title
        self.subtitle = subtitle
        self.trailingContent = trailingContent()
    }
    
    public var body: some View {
        HStack(spacing: 12) {
            // Your signature rounded icon
            ZStack {
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(iconColor)
                    .frame(width: 28, height: 28)
                
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.white)
            }
            
            // Text Content
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .foregroundStyle(.primary)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
            }
            
            Spacer()
            
            // Injected specific control (Toggle, Chevron, Status text)
            trailingContent
        }
        // Removes generic list row separators on macOS so it looks cleaner
        #if os(macOS)
        .padding(.vertical, 4)
        #endif
    }
}
