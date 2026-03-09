//
//  SKNavigationRow.swift
//  SettingsKitUI
//
//  Created by Haaris Iqubal on 25/02/26.
//

import SwiftUI

import SwiftUI

// MARK: Navigation Row

/// A view that represents a navigational row, wrapping an `SKBaseRow` inside a `NavigationLink`.
///
/// Use `SKNavigationRow` to create consistent list or form rows that navigate to a new destination view when tapped.
/// It displays an icon, title, and an optional subtitle.
///
/// ### Basic Example
/// ```swift
/// SKNavigationRow(
///     icon: "gear",
///     iconColor: .gray,
///     title: "Settings"
/// ) {
///     SettingsView()
/// }
/// ```
///
/// ### Advanced Example
/// ```swift
/// SKList {
///     SKSection {
///         SKNavigationRow(
///             icon: "person.crop.circle.fill",
///             iconColor: .blue,
///             title: "Profile",
///             subtitle: "Manage your personal information"
///         ) {
///             ProfileDetailView(userID: currentUser.id)
///         }
///     } header: {
///         Text("Account")
///         }
/// }
/// ```
public struct SKNavigationRow<Destination: View>: View {
    
    // MARK: Properties
    
    /// The name of the SF Symbol or image asset to display as the row's icon.
    public let icon: String?
    
    /// The color used to tint the icon.
    public let iconColor: Color?
    
    /// The primary text displayed in the row.
    public let title: String
    
    /// The secondary text displayed beneath the title. This property is optional.
    public let subtitle: String?
    
    /// The view to navigate to when the row is tapped.
    @ViewBuilder public let destination: Destination
    
    // MARK: - Initialization
    
    /// Creates a new navigation row with an icon, tint color, title, optional subtitle, and a destination view.
    ///
    /// - Parameters:
    ///   - icon: A string representing the image or SF Symbol name.
    ///   - iconColor: The color used to tint the icon.
    ///   - title: The primary text to display.
    ///   - subtitle: The optional secondary text to display. Defaults to `nil`.
    ///   - destination: A view builder that creates the destination view.
    public init(icon: String? = nil, iconColor: Color? = nil, title: String, subtitle: String? = nil, @ViewBuilder destination: () -> Destination) {
        self.icon = icon
        self.iconColor = iconColor
        self.title = title
        self.subtitle = subtitle
        self.destination = destination()
    }
    
    // MARK: - Body
    
    /// The content and behavior of the navigation row.
    public var body: some View {
        NavigationLink(destination: destination) {
            SKBaseRow(icon: icon, iconColor: iconColor, title: title, subtitle: subtitle)
        }
    }
}

//MARK: Preview
#Preview {
    NavigationStack{
        SKList {
            SKSection {
                SKNavigationRow(
                    icon: "person.crop.circle.fill",
                    iconColor: .blue,
                    title: "Profile",
                    subtitle: "Manage your personal information"
                ) {
                    Text("Preview")
                }
                SKNavigationRow(icon: "person.crop.circle", title: "Profile Password", destination: {
                    Text("Password")
                })
                .skBaseRowIconColor(.green)
                .skBaseRowFontSize(.title)
            } header: {
                Text("Account")
            }
        }
    }
}
