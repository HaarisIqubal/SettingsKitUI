//
//  SKBaseRow.swift
//  SettingsKitUI
//
//  Created by Haaris Iqubal on 25/02/26.
//

import SwiftUI

//MARK: Universal Row for row styling
/// A base row style builds a basic building block of `SettingsKitUI`.
///
/// `SKBaseRow` has some standard styling for basic row which acts as a building block of whole UI system. It has optional `icon` and `subtitle` option user can also control labels icon to be hidden or shown and also style background of the icon.
///
/// `SKBaseRow` has an optional trailing content so developer can customise the trailing part.
///
/// ### Example Usage
/// #### Basic example
/// ```swift
/// SKBaseRow(icon: "cloud.fill", iconColor: .blue, title: "iCloud")
/// ```
/// #### More Advance examples
/// ```swift
///SKList{
///     SKBaseRow(icon: "cloud.fill", iconColor: .blue, title: "iCloud", subtitle: "Sync data to cloud") {
///         Image(systemName: "chevron.right")
///        .opacity(0.4)
///}
///
///     SKBaseRow(icon: "book.fill", iconColor: .brown, title: "Library")
///         .skIconShape(.circle)
///
///     SKBaseRow(icon: "trash.fill", iconColor: .red, title: "Delete data", subtitle: "Delete device data")
///         .skShowsIcon(false)
///}
/// ```
public struct SKBaseRow<TrailingContent: View>: View {
    public let icon: String?
    public let iconColor: Color?
    public let title: String
    public let subtitle: String?
    @ViewBuilder public let trailingContent: TrailingContent
    
    @ScaledMetric(relativeTo: .body) private var backgroundSize: CGFloat = 28
    @ScaledMetric(relativeTo: .body) private var symbolSize: CGFloat = 16
    
    @Environment(\.skBaseRowIconColor) private var baseIconColor
    @Environment(\.skBaseRowShowsIcon) private var showsIcon
    @Environment(\.skBaseRowIconShape) private var iconShape
    @Environment(\.skBaseRowIconFontSize) private var iconFontSize
    
    //MARK: Initialiser 1 - With icon and icon color
    /// Creates a baserow with icon, iconColor, title, subtitle and trailing content.
    ///  - Parameters:
    ///     - icon: `SFSymbol` icon name
    ///     - iconColor: `Color` of icon
    ///     - title: The primary label of row.
    ///     - subtitle: The secondary label of row.
    ///     - trailingContent: Optional trailing view if needed.
    public init(
        icon: String? = nil,
        iconColor: Color? = nil,
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
    
    //MARK: Initialiser 2 - Only consist of title, subtitle and trailing content.
    /// Creates a baserow only with title, subtitle and trailing content.
    ///  - Parameters:
    ///     - title: The primary label of row.
    ///     - subtitle: The secondary label of row.
    ///     - trailingContent: Optional trailing view if needed.
    public init(title: String, subtitle:String? = nil, @ViewBuilder trailingContent: () -> TrailingContent = {EmptyView()}) {
        self.icon = nil
        self.iconColor = nil
        self.title = title
        self.subtitle = subtitle
        self.trailingContent = trailingContent()
    }
    
    //MARK: Body
    public var body: some View {
        HStack(spacing: 12) {
            if showsIcon, let icon = icon {
                Image(systemName: icon)
                    .foregroundStyle(baseIconColor)
                    .font(iconColor != nil ? .system(size: symbolSize) : iconFontSize)
                    .frame(width: backgroundSize , height: backgroundSize)
                    .background(iconBackgroundShape)
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
                RoundedRectangle(cornerRadius: 8, style: .continuous)
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

private struct SKBaseRowIconColor: EnvironmentKey {
    static let defaultValue: Color = .white
}

private struct SKBaseRowIconFontSize: EnvironmentKey {
    static let defaultValue: Font = .body
}

public extension EnvironmentValues {
    var skBaseRowShowsIcon: Bool {
        get { self[SKShowsIconKeys.self] }
        set { self[SKShowsIconKeys.self] = newValue}
    }
    
    @MainActor
    var skBaseRowIconShape: SKIconShape {
        get { self[SKIconShapeKey.self]}
        set { self[SKIconShapeKey.self] = newValue}
    }
    
    var skBaseRowIconColor: Color {
        get {self[SKBaseRowIconColor.self]}
        set {self[SKBaseRowIconColor.self] = newValue}
    }
    
    var skBaseRowIconFontSize: Font {
        get {self[SKBaseRowIconFontSize.self]}
        set {self[SKBaseRowIconFontSize.self] = newValue}
    }
}

public extension View {
    /// Controls whether the `SKBaseRow` icon is displayed.
    ///     - Parameters shows: `false` to hide the icon completely.
    func skBaseRowShowsIcon(_ shows: Bool) -> some View {
        self.environment(\.skBaseRowShowsIcon, shows)
    }
    
    /// Changes the background shape of the `SKBaseRow` icon.
    ///     - Parameters shape: The `SKIconShape` to apply (eg., `.circle`).
    func skBaseRowIconShape(_ shape: SKIconShape) -> some View {
        self.environment(\.skBaseRowIconShape, shape)
    }
    
    ///Changes the icon foreground color for icon image
    /// - Parameters:
    ///     - color: The SwiftUI native color style.
    func skBaseRowIconColor(_ color: Color) -> some View {
        self.environment(\.skBaseRowIconColor, color)
    }
    
    ///Changes the icon size of row when there is no background color
    /// - Parameters:
    ///     - font: The SwiftUI native font class
    func skBaseRowFontSize(_ font: Font) -> some View {
        self.environment(\.skBaseRowIconFontSize, font)
    }
}


//MARK: Preview

#Preview {
    SKList{
        SKBaseRow(icon: "cloud.fill", iconColor: .blue, title: "iCloud", subtitle: "Sync data to cloud") {
            Image(systemName: "chevron.right")
                .opacity(0.4)
        }
        
        SKBaseRow(icon: "book.fill", iconColor: .brown, title: "Library")
            .skBaseRowIconShape(.circle)
        
        SKBaseRow(icon: "trash.fill", iconColor: .red, title: "Delete data", subtitle: "Delete device data")
            .skBaseRowShowsIcon(false)
        
        SKBaseRow(icon: "phone.fill", title: "Phone")
            .skBaseRowIconColor(.blue)
    }
}
