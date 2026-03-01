//
//  PreviewTest.swift
//  SettingsKitUI
//
//  Created by Haaris Iqubal on 01/03/26.
//

import SwiftUI


struct MySettingsView: View {
    
    
        // MARK: State Properties
    @State private var notificationsEnabled = true
    @State private var appTheme = 0
    
    
    var body: some View {
        SKList {
            SKSection {
                SKToggleRow(
                    icon: "bell.fill",
                    iconColor: .red,
                    title: "Notifications",
                    isOn: $notificationsEnabled
                )
                
                
                SKPickerRow(
                    icon: "paintpalette.fill",
                    iconColor: .indigo,
                    title: "Theme",
                    selection: $appTheme
                ) {
                    Text("Light").tag(0)
                    Text("Dark").tag(1)
                }
            } header: {
                Text("Preferences")
            }
            
            
                // MARK: Account Section
            SKSection {
                SKNavigationRow(
                    icon: "person.crop.circle",
                    iconColor: .blue,
                    title: "Profile"
                ) {
                    Text("Profile Detail View")
                }
            }
            header: {
                Text("Account")
            }
        }
    }
}

#Preview {
    MySettingsView()
}
