# Getting Started with SettingsKitUI

@Metadata{
    @PageImage(purpose: icon, source: "SKBasicSetting", alt: "SKBasic Image")
    @PageColor(blue)
}
Learn how to quickly build a structured, native-feeling settings screen using SettingsKitUI.

## Overview

SettingsKitUI provides a declarative, SwiftUI-native approach to building complex preference screens. By leveraging our pre-built rows and layouts, you can assemble a complete settings experience in minutes without worrying about the underlying layout boilerplate.

This guide will walk you through creating a basic settings page, complete with navigation, toggles, and picker controls.

In this guide the final view appear much more like this
![Basic Setting View](SKBasicSetting)

### Step 1: Set Up Your List

Every SettingsKitUI screen starts with an `SKList` or `SKForm` to host your content. The `SKList` or `SKForm` provides the familiar grouped list styling. You have choice to use one or both of them.

```swift
import SwiftUI
import SettingsKitUI

struct MySettingsView: View {
var body: some View {
    SKList {
        // Components will go here
        }
    }
}
```

### Step 2: Add a Section with Controls
Settings are typically grouped by context. Let's add an SKSection to hold a toggle switch for notifications. We will use `SKToggleRow` to handle the user's input.

```swift
import SwiftUI
import SettingsKitUI

struct MySettingsView: View {

// MARK: State Properties
@State private var notificationsEnabled = true

var body: some View {
    SKList {
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
```



### Step 3: Adding more settings options
There is always much more than a toggle button, `SettingKitUI` provide other input method so you can add more complex setting screen. Let add a `SKPickerRow` to let user to choose from different options.

```swift
import SwiftUI
import SettingsKitUI

struct MySettingsView: View {

// MARK: State Properties
@State private var notificationsEnabled = true
@State private var appTheme = 0

var body: some View {
    SKList {
        SKSection(header: "Preferences") {
            SKToggleRow(
            icon: "bell.fill",
            iconColor: .red,
            title: "Notifications",
            subtitle: "Allow push notifications",
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
    }
 }
}
```

## Next Steps
Now that you have built your first settings screen, explore the rest of the framework to see how you can customize your rows and build deeper navigational hierarchies.
 - ``doc:SKActionRow``
 - ``SKBaseRow``
