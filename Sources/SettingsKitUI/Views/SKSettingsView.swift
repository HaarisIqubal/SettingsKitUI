//
//  SKSettingsView.swift
//  SettingsKitUI
//
//  Created by Haaris Iqubal on 25/02/26.
//

import SwiftUI

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
    @Environment(\.horizontalSizeClass) private var sizeClass
    
    @State private var selection: String?
    
    public init(pages: [SKPage]) {
        self.pages = pages
        self._selection = State(initialValue: pages.first?.id)
    }
    
    public var body: some View {
        #if os(macOS)
        Group {
            if style == .sidebar {
                sidebarLayout
            } else {
                tabLayout
            }
        }
        .frame(minWidth: 500, minHeight: 400)
        #else
        sidebarLayout
        #endif
    }
    
    //MARK: Layout Resolving
    private var resolvedStyle: SKSettingsStyle {
        if style != .automatic {return style}
        
        #if os(macOS)
        return style == .automatic ? .tabs : style
        #elseif os(iOS)
        return .sidebar
        #else
        return .sidebar
        #endif
    }
    
    
    //MARK: Sidebar Layout
    private var sidebarLayout: some View {
        NavigationSplitView {
            List(pages, selection: $selection) {page in
                NavigationLink(value: page.id) {
                    SKBaseRow(icon: page.systemIcon, iconColor: nil, title: page.title)
                }
            }
            .navigationTitle("Settings")
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200, max: 250)
#endif
        }
        detail: {
            if let selectedId = selection, let selectedPage = pages.first(where: {$0.id == selectedId}) {
                selectedPage.view.navigationTitle(selectedPage.title)
            } else {
                Text("Select a setting")
                    .foregroundStyle(.secondary)
            }
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
                    SKList{
                        SKForm{
                            SettingGeneralSection()
                        }
                    }
                }),
                SKPage(title: "Sync", systemIcon: "cloud.fill", content: {
                    SKList{
                        SKForm{
                            SettingSyncSection()
                        }
                    }
                }),
                SKPage(title: "Privacy", systemIcon: "hand.raised.fill", content: {
                    SKList {
                        SettingPrivacySection()
                    }
                }),
                SKPage(title: "Support", systemIcon: "phone", content: {
                    SKList {
                        SettingSupportSection()
                        SettingAppSection()
                    }
                })
            ])
            .skSettingsStyle(.sidebar)
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
            SKActionRow(icon: "purchased", iconColor: .blue, title: "Restore purchases", action: {
                
            })
            
            SKActionRow(icon: "star.fill", iconColor: .yellow, title: "What's new", action: {
                
            })
            SKActionRow(icon: "wand.and.stars", iconColor: .purple, title: "New Features", action: {
                
            })
            SKToggleRow(icon: "shuffle", iconColor: .orange, title: "Shuffle cards", isOn: .constant(.random()))
        } header: {
            Text("General")
        }
        .skShowsIcon(false)
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
