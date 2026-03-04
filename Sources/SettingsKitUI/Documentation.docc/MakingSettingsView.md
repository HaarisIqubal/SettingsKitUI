# Start making Settings View

@Metadata{
    @PageImage(purpose: card, source: "SKSettingViewBasic", alt: "The profile icon for article of start making settings view.")
    @PageCol or(purple)
}

Learn how to construct a multi-page, platform-native settings experience using SettingsKitUI.

## Overview

Now that you have learned the basics of assembling individual rows in <doc:MakingSettingsView>, it is time to look at the bigger picture. Real-world applications rarely fit all their preferences onto a single screen.

In this article, we will explore how to elevate your UI by transitioning from a basic form to a fully structured, multi-page settings architecture. We will use `SKSettingsView` to automatically handle native navigation paradigms across iOS, iPadOS, and macOS.

The final view of this article looks something like this
![SKSettingView Page View](SKSettingViewBasic)

### Step 1: The Multi-Platform Advantage

When building for Apple platforms, context is everything. An iPhone or iPad app typically uses a List or deep navigation stacks for settings, whereas an or Mac app expects a `NavigationSplitView` with a sidebar. 

Instead of writing custom layout logic for every device, `SettingsKitUI` provides `SKSettingsView`. By wrapping your `SKPage` components inside this root view, the framework automatically adapts your layout to match the exact device the user is holding.

### Step 2: Defining Your Root Pages

Let's start by defining our root `SKSettingsView` and giving it an array of pages. For a real-world app, we might want one page for "General" settings and another for "Account" details.

```swift
import SwiftUI
import SettingsKitUI

struct AppSettingsView: View {
    var body: some View {
        SKSettingsView(pages: [
        SKPage(title: "General", systemIcon: "gear") {
            SKList {
            // Content goes here
            }
        },
        SKPage(title: "Account", systemIcon: "person.crop.circle") {
            SKList {
            // Content goes here
            }
        }
        ])
    }
}
```

### Step 3: Populating a Realistic Settings Page
Now let's fill in our "General" page with real-world controls. We will use `SKSection` to logically group our preferences, an `SKToggleRow` for binary choices, and an `SKPickerRow` for multiple-choice themes.

Notice how combining these components instantly creates a production-ready aesthetic.

```swift
import SwiftUI
import SettingsKitUI

struct AppSettingsView: View {

// MARK: State Properties

@State private var notificationsEnabled = true
@State private var backgroundRefresh = false
@State private var appTheme = 0

var body: some View {
SKSettingsView(pages: [

    // MARK: General Page
    SKPage(title: "General", systemIcon: "gear") {
    SKList {

        SKSection(header: "Preferences") {
            SKPickerRow(
            icon: "paintpalette.fill",
            iconColor: .indigo,
            title: "Appearance",
            selection: $appTheme
            ) {
                Text("System").tag(0)
                Text("Light").tag(1)
                Text("Dark").tag(2)
            }
        }

        SKSection(header: "Background Tasks", footer: "Allowing background refresh keeps your content up to date but may consume more battery.") {
            SKToggleRow(
            icon: "bell.fill",
            iconColor: .red,
            title: "Push Notifications",
            isOn: $notificationsEnabled
            )

            SKToggleRow(
            icon: "arrow.clockwise",
            iconColor: .green,
            title: "Background Refresh",
            isOn: $backgroundRefresh
            )
        }
    }
    },

    // MARK: Account Page
    SKPage(title: "Account", systemIcon: "person.crop.circle") {
    SKList {
        SKSection(header: "Profile Management") {
            SKNavigationRow(
            icon: "person.text.rectangle.fill",
            iconColor: .blue,
            title: "Personal Information",
            subtitle: "Update your name, email, and phone number."
            ) {
                Text("Personal Info Form View")
            }

            SKNavigationRow(
            icon: "lock.shield.fill",
            iconColor: .orange,
            title: "Security & Passwords"
            ) {
                Text("Security View")
            }
        }
    }
    }
    ])
}
}
```

## Next Steps

With `SKSettingsView` successfully routing your pages, you now have a highly scalable foundation for your application's preferences.


Try adding custom interactive elements using <doc:SKActionRow> to handle things like "Log Out" or "Delete Account" buttons at the bottom of your Account page.
