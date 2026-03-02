    //
    //  SKSettingsView.swift
    //  SettingsKitUI
    //
    //  Created by Haaris Iqubal on 25/02/26.
    //

import SwiftUI

    //MARK: Settings Style Enum
public enum SKSettingsStyle : Sendable{
        /// Automatically chooses the best layout according to UI
    case automatic
        /// Forces a Tab-based layout (Toolbar tabs on macOS)
    case tabs
        /// Forces a Sidebar-based layout using NavigationSplitView
    case sidebar
}

    //MARK: Environment Setup
private struct SKSettingsStyleKey: EnvironmentKey {
    static let defaultValue: SKSettingsStyle = .automatic
}

private struct SKSettingsSidebarNavigationTitle: EnvironmentKey {
    static let defaultValue: String = ""
}

public extension EnvironmentValues {
    var skSettingsStyle: SKSettingsStyle {
        get {self[SKSettingsStyleKey.self]}
        set {self[SKSettingsStyleKey.self] = newValue}
    }
    
    var skSettingsSidebarNavigationTitle: String {
        get {self[SKSettingsSidebarNavigationTitle.self]}
        set {self[SKSettingsSidebarNavigationTitle.self] = newValue}
    }
}

public extension View {
        /// Sets the layout style for `SKSettingsView`.
        /// - Parameters:
        ///     - style: The `SKSettingsStyle` to apply (.tabs or .sidebar).
    func skSettingsStyle(_ style: SKSettingsStyle) -> some View {
        self.environment(\.skSettingsStyle, style)
    }
    
        /// Sets the sidebar navigation title for `SKSettingsView`
        /// - Parameters:
        ///     - title: Navigation title for sidebar
    func skSettingsSidebarTitle(_ title: String) -> some View {
        self.environment(\.skSettingsSidebarNavigationTitle, title)
    }
}

    //MARK: Universal Settings Router
    /// A high level view for Settings that orchestrates multiple settings page.
    ///
    /// Use `SKSettingsView` at the root of yout settings window or view. It automatically renders as a Sidebar or TabView depending on the platform and environment modifiers.
    ///
    /// ### Example Usage
    /// ```swift
    /// SKSettingsView(pages: [
    ///     SKPage(title: "General", systemIcon: "gear") {
    ///         GeneralSettingsList() // Your SKList goes here
    ///     },
    ///     SKPage(title: "Sync", systemIcon: "cloud") {
    ///         SyncSettingsList() // Your SKList goes here
    ///     }
    /// ])
    /// .skSettingsStyle(.sidebar) // Force split view!
    /// ```
public struct SKSettingsView: View {
    public let pages: [SKPage]
    
    @Environment(\.skSettingsStyle) private var style
    @Environment(\.skSettingsSidebarNavigationTitle) private var sidebarNavigationTitle
    @Environment(\.horizontalSizeClass) private var sizeClass
    
    @State private var selection: String?
    
        //MARK: Initialiser - Setting View initialiser for native UI.
        /// Creates a basic settings view requires `SKPage`
        ///
        /// - Parameters:
        ///     - pages: Collection for `SKPage`.
    public init(pages: [SKPage]) {
        self.pages = pages
        self._selection = State(initialValue: pages.first?.id)
    }
    
    public var body: some View {
#if os(macOS)
        resolvedStyle
            .frame(minWidth: 500, minHeight: 400)
#else
        sidebarLayout
#endif
    }
    
        //MARK: Layout Resolving
    @ViewBuilder private var resolvedStyle: some View {
        switch style {
        case .tabs, .automatic:
            tabLayout
        case .sidebar:
            sidebarLayout
        }
    }
    
        //MARK: Sidebar Layout
    private var sidebarLayout: some View {
        NavigationSplitView {
            SKList(pages, selection: $selection) { page in
                NavigationLink(value: page.id) {
                    SKBaseRow(icon: page.systemIcon, iconColor: nil, title: page.title)
                        .skBaseRowIconColor(.blue)
                }
            }
            .toolbar(removing: .sidebarToggle)
            .navigationTitle(sidebarNavigationTitle)
            .listStyle(.sidebar)
            .frame(minWidth: 200)
        }
        detail: {
            Group{
                if let selectedId = selection, let selectedPage = pages.first(where: {$0.id == selectedId}) {
                    selectedPage.view.navigationTitle(selectedPage.title)
                } else {
                    Text("Select a setting")
                        .foregroundStyle(.secondary)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 440, ideal: 440)
#endif
        }
    }
    
        //MARK: Tab Layout
    private var tabLayout: some View {
        TabView {
            ForEach(pages) {page in
                page.view.tabItem{
                    Label(page.title, systemImage: page.systemIcon)
                }
                .tag(page.id)
            }
        }
    }
}




//MARK: Preview

struct SettingNew: View {
    @Environment(\.horizontalSizeClass) var sizeclass
    var body: some View {
        if sizeclass == .compact {
            SKList {
                SettingGeneralSection()
                SettingSyncSection()
                SettingPrivacySection()
                SettingSupportSection()
                SettingAppSection()
                }
            } else {
                SKSettingsView(pages: [
                SKPage(title: "General", systemIcon: "gear", content: {
                    SKForm{
                        SettingGeneralSection()
                        }
                    }),
                SKPage(title: "Sync", systemIcon: "cloud.fill", content: {
                    SKForm{
                        SettingSyncSection()
                        }
                    }),
                SKPage(title: "Privacy", systemIcon: "hand.raised.fill", content: {
                    SKForm{
                        SettingPrivacySection()
                        }
                    }),
                SKPage(title: "Support", systemIcon: "phone", content: {
                    SKForm{
                        Group{
                            SettingSupportSection()
                            SettingAppSection()
                            }
                        }
                    })
                ])
                .skSettingsStyle(.tabs)
                }
        }
}

#Preview {
    SettingNew()
}

#Preview("Sidebar Style") {
    SKSettingsView(pages: [
    SKPage(title: "General", systemIcon: "gear") {
        SKList {
            SKSection {
                SKActionRow(icon: "paintpalette.fill", iconColor: .purple, title: "Theme", subtitle: "Dark Mode") {}
                } header: {
                    Text("Appearance")
                    }
            }
        },
    SKPage(title: "Sync", systemIcon: "cloud.fill") {
        SKList {
            SKSection {
                SKActionRow(icon: "icloud.fill", iconColor: .blue, title: "iCloud Sync", subtitle: "Active") {}
                }
            }
        }
    ])
    .skSettingsStyle(.tabs)
}

//MARK: Smaller Sections
struct SettingGeneralSection: View {
    var body: some View {
        SKSection {
            SKActionRow(icon: "purchased", iconColor: .blue, title: "Restore purchases", subtitle: "Tap to restore your previous purchases.", action: {
                
                })
            
            SKActionRow(icon: "star.fill", iconColor: .yellow, title: "What's new", action: {
                
                })
            SKActionRow(icon: "wand.and.stars", iconColor: .purple, title: "New Features", action: {
                
                })
            SKToggleRow(icon: "shuffle", iconColor: .orange, title: "Shuffle cards", isOn: .constant(.random()))
            } header: {
                Text("General")
                }
#if os(macOS)
        .skBaseRowShowsIcon(false)
#endif
        //        .skIconShape(.roundedRectangle(8))
        }
}

struct SettingSyncSection: View {
            var body: some View{
                SKSection {
                    SKToggleRow(icon: "cloud.fill", iconColor: .blue, title: "iCloud sync", isOn: .constant(.random()))
                    SKActionRow(icon: "xmark.icloud.fill", iconColor: .red, title: "Delete iCloud data", action: {
                        
                    })
                } header: {
                    Text("Sync")
                } footer: {
                    Text("Toggling iCloud Sync may require to close the app.\n")
                    +
                    Text("Delete iCloud Data will delete you personal data on iCloud your app data will be unaffected.")
                }
            }
}

struct SettingPrivacySection: View {
    var body: some View {
        SKSection {
            SKActionRow(icon: "externaldrive.fill.badge.xmark", iconColor: .pink, title: "Delete app data", action: {})
            
            SKActionRow(icon: "hand.raised.fill", iconColor: .blue, title: "Privacy policy", action: {})
            SKActionRow(icon: "applescript.fill", iconColor: .pink, title: "Terms and conditions", action: {})
        } header: {
            Text("Privacy")
        } footer: {
            Text("Delete App Data will delete you personal data you need to close the app. \n")
        }
    }
}

struct SettingSupportSection: View {
    var body: some View{
        SKSection{
            SKActionRow(icon: "envelope.badge.fill", iconColor: .orange, title: "Feature request", action: {})
            SKActionRow(icon: "ladybug.fill", iconColor: .red, title: "Bug report", action: {})
        } header: {
            Text("Support")
        }
    }
}

struct SettingAppSection: View {
    var body: some View {
        SKSection{
            SKActionRow(icon: "globe", iconColor: .blue, title: "Follow on X (@haaris_iqubal)", action: {})
            SKActionRow(icon: "globe", iconColor: .blue, title: "Follow on X (@mmkbaig)", action: {
                
            })
            SKActionRow(icon: "gear", iconColor: .gray, title: "Open Settings", action: {})
        } header: {
            Text("Deck app")
        }
    }
}

#Preview("Header") {
    @Previewable @State var notificationsEnabled = false
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

#Preview("SK Page Example") {
    @Previewable @State var notificationsEnabled = false
    @Previewable @State var appTheme = 1
    SKSettingsView(pages: [
        SKPage(title: "Setting", systemIcon: "gear", content: {
            SKList{
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
        })
    ])
}
