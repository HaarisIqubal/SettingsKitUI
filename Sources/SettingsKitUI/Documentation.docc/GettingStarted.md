# Getting Started with SettingsKitUI

Learn how to quickly build a structured, native-feeling settings screen using SettingsKitUI.

## Overview

SettingsKitUI provides a declarative, SwiftUI-native approach to building complex preference screens. By leveraging our pre-built rows and layouts, you can assemble a complete settings experience in minutes without worrying about the underlying layout boilerplate.

This guide will walk you through creating a basic settings page, complete with navigation, toggles, and picker controls.

## Step 1: Set Up Your List

Every SettingsKitUI screen starts with an `SKList` and an `SKForm` to host your content. The `SKPage` acts as the primary container, while the `SKForm` provides the familiar grouped list styling.

```swift
import SwiftUI
import SettingsKitUI

struct MySettingsView: View {
var body: some View {
    SKList {
        SKForm {
            // Components will go here
            }
        }
    }
}
```

## Step 2: Add a Section with Controls
Settings are typically grouped by context. Let's add an SKSection to hold a toggle switch for notifications. We will use `SKToggleRow` to handle the user's input.

```swift
import SwiftUI
import SettingsKitUI

struct MySettingsView: View {

// MARK: State Properties
@State private var notificationsEnabled = true

var body: some View {
    SKPage(title: "Settings") {
        SKForm {
            SKSection(header: "Preferences") {
                SKToggleRow(
                icon: "bell.fill",
                iconColor: .red,
                title: "Notifications",
                subtitle: "Allow push notifications",
                isOn: $notificationsEnabled
                )
                }
            }
        }
    }
}
```

## Step 3: Implement Navigation and Pickers

Next, let's add another section for account details using `SKNavigationRow` to navigate to a deeper view, and an `SKPickerRow` to select an app theme.

```swift
import SwiftUI
import SettingsKitUI

struct MySettingsView: View {

// MARK: State Properties
@State private var notificationsEnabled = true
@State private var appTheme = 0

var body: some View {
    SKPage(title: "Settings") {
        SKForm {

    // MARK: Preferences Section
        SKSection(header: "Preferences") {
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
        }

        // MARK: Account Section
        SKSection(header: "Account") {
        SKNavigationRow(
        icon: "person.crop.circle",
        iconColor: .blue,
        title: "Profile"
        ) {
        Text("Profile Detail View")
        }
        }

        }
        }
    }
}
```

## Next Steps
Now that you have built your first settings screen, explore the rest of the framework to see how you can customize your rows and build deeper navigational hierarchies.
 - ``doc:SKActionRow``
 - ``SKBaseRow``
