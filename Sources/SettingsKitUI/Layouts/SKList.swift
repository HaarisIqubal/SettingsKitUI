//
//  SKList.swift
//  SettingsKitUI
//
//  Created by Haaris Iqubal on 25/02/26.
//

import SwiftUI

// MARK: Universal List View

/// A cross-platform wrapper around SwiftUI's native `List`.
///
/// `SKList` standardizes the appearance of list-based settings views across different Apple platforms.
/// It automatically applies `.insetGrouped` styling on iOS and hides the scroll content background on macOS
/// to ensure a clean, native look without requiring platform-specific `#if` compiler directives in your app's codebase.
///
/// ### Example Usage
/// ```swift
/// SKList {
///     SKSection(header: { Text("Preferences") }) {
///         SKActionRow(icon: "car", iconColor: .blue, title: "Car", subtitle: "Open Car") {
///             print("Action Triggered")
///         }
///     }
/// }
/// ```
public struct SKList<SelectionValue: Hashable, Content: View>: View {
    // MARK: Properties
        
        /// The underlying data associated with the list, if applicable.
        public var data: Data?
        
        /// A binding to the currently selected value, or `nil` if selection is disabled or nothing is selected.
        public var selection: Binding<SelectionValue?>?
        
        /// The view content displayed within the list.
        @ViewBuilder public var content: Content
    
    // MARK: Initialization
    /// Creates a new cross-platform list with data, a selection binding, and custom content.
    ///
    /// - Parameters:
    ///   - data: The data to associate with the list.
    ///   - selection: A binding to a selected value.
    ///   - content: A view builder that provides the sections and rows for the list.
    public init(_ data:Data?, selection: Binding<SelectionValue?>, @ViewBuilder content: () -> Content) {
        self.data = data
        self.selection = selection
        self.content = content()
    }
    
    //MARK: Body
    
    public var body: some View {
        List(selection: selection) {
            content
        }
#if os(macOS)
        .scrollContentBackground(.hidden)
#endif
    }
}

//MARK: Extension

extension SKList where SelectionValue == Never {
    /// Creates a new cross-platform list with the specified content.
    ///
    /// Use this initializer when your list does not require item selection.
    ///
    /// - Parameters:
    ///    - content: `A view builder closure that provides the sections and rows for the list.`
    public init(@ViewBuilder content: () -> Content) {
        self.selection = nil
        self.content = content()
    }
}

extension SKList {
    /// Creates a list that computes its rows from an underlying collection of data, supporting selection.
    ///
    /// - Parameters:
    ///   - data: The collection of identifiable data.
    ///   - selection: A binding to a selected value.
    ///   - rowContent: A view builder that creates a row for each item in the data.
    init<Data: RandomAccessCollection, RowContent: View>(_ data: Data, selection: Binding<SelectionValue?>, @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent) where Content == ForEach<Data, Data.Element.ID, RowContent>, Data.Element: Identifiable {
        self.selection = selection
        self.content = ForEach(data, content: rowContent)
    }
}

// MARK: Previews

#Preview {
    NavigationStack {
        SKList {
            SKSection {
                SKActionRow(
                    icon: "pencil",
                    iconColor: .brown,
                    title: "Edit",
                    subtitle: "Open edit",
                    action: {}
                )
                SKActionRow(
                    icon: "ladybug.fill",
                    iconColor: .red,
                    title: "Report Bug",
                    action: {}
                )
                SKToggleRow(icon: "cloud.fill", iconColor: .blue, title: "iCloud Sync", isOn: .constant(.random()))
                
            } header: {
                Text("Header")
            } footer : {
                Text("This footer section for describing how it will look like.")
            }
        }
        .navigationTitle("Settings Preview")
    }
}
