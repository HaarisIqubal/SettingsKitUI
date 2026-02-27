//
//  SKBaseRow.swift
//  SettingsKitUI
//
//  Created by Haaris Iqubal on 25/02/26.
//

import SwiftUI

public struct SKBaseRow<TrailingContent: View>: View {
    public let icon: String?
    public let iconColor: Color?
    public let title: String
    public let subtitle: String?
    @ViewBuilder public let trailingContent: TrailingContent
    
    @Environment(\.skShowsIcon) private var showsIcon
    @Environment(\.skIconShape) private var iconShape
    
    public init(
        icon: String? = nil,
        iconColor: Color?,
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
            if showsIcon {
                ZStack {
                    iconBackgroundShape
                    if let icon = icon {
                        Image(systemName: icon)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.white)
                    }
                }
                .frame(width: 28, height: 28)
            }
            
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
            
            trailingContent
        }
#if os(macOS)
        .padding(.vertical, 4)
#endif
    }
    
    @ViewBuilder
    private var iconBackgroundShape: some View {
        if let iconColor = iconColor {
            switch iconShape {
            case .standard:
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(iconColor)
            case .circle:
                Circle()
                    .fill(iconColor)
            case .roundedRectangle(let radius):
                RoundedRectangle(cornerSize: .init(width: radius, height: radius), style: .continuous)
                    .fill(iconColor)
            }
        }
    }
}

// MARK: Icon Share Definition
public enum SKIconShape {
    /// The default rounded rectangle (corner radius 12)
    case standard
    /// A perfectly rounded circle
    case circle
    /// A custom rounded rectangle with a specific corner radius
    case roundedRectangle(CGFloat)
}

// MARK: Environment Keys
private struct SKShowsIconKeys: EnvironmentKey {
    static let defaultValue: Bool = true
}

private struct SKIconShapeKey: @MainActor EnvironmentKey {
    @MainActor static let defaultValue: SKIconShape = .standard
}

public extension EnvironmentValues {
    var skShowsIcon: Bool {
        get { self[SKShowsIconKeys.self] }
        set { self[SKShowsIconKeys.self] = newValue}
    }
    
    @MainActor
    var skIconShape: SKIconShape {
        get { self[SKIconShapeKey.self]}
        set { self[SKIconShapeKey.self] = newValue}
    }
}

public extension View {
    /// Controls whether the `SKBaseRow` icon is displayed.
    ///     - Parameters shows: `false` to hide the icon completely.
    func skShowsIcon(_ shows: Bool) -> some View {
        self.environment(\.skShowsIcon, shows)
    }
    
    /// Changes the background shape of the `SKBaseRow` icon.
    ///     - Parameters shape: The `SKIconShape` to apply (eg., `.circle`).
    func skIconShape(_ shape: SKIconShape) -> some View {
        self.environment(\.skIconShape, shape)
    }
}


