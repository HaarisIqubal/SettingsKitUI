//
//  SKFrom.swift
//  SettingsKitUI
//
//  Created by Haaris Iqubal on 27/02/26.
//

import SwiftUI

//MARK: Universal Form for settings styling
/// A Form view builder which is wrapper around Native SwiftUI `Form`
///
/// `SKForm` standardizes the appearance of settings view for `SKList` view.
/// It automatically applies `.group` form style which provides standard group settings like macOS.
/// ### Example Usage
/// ```swift
/// SKForm {
///     SKList {
///        SKSection(header: { Text("Preferences") }) {
///          SKActionRow(icon: "car", iconColor: .blue, title: "Car", subtitle: "Open Car") {
///             print("Action Triggered")
///         }
///     }
///     }
///}
/// ```
public struct SKForm<Content: View>: View {
    
    /// This is visual content shown inside the view
    @ViewBuilder public let content: Content
    
    /// Creates from grouped style view for `SKList` views.
    /// - Parameter content: A view builder closures that provide views inside the form.
    public init(content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        Form {
            content
        }
    }
}
