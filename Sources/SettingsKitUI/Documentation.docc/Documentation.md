# ``SettingsKitUI``

A composable, cross-platform SwiftUI library for building beautiful native Settings screens.

## Overview

SettingsKitUI solves the problem of maintaining redundant settings code across iOS, iPadOS, macOS, watchOS, and visionOS. By providing highly abstract, platform-aware UI building blocks, you can write your settings hierarchy once and let the kit handle the platform-specific quirks.

The package enforces Apple's Human Interface Guidelines automatically, translating your code into a `NavigationSplitView` on iPad, a `TabView` on macOS, and a standard push-navigation list on iPhone.

## Featured

@Links(visualStyle: detailedGrid) {
    - <doc:GettingStarted>
    - <doc:MakingSettingsView>
}

## Architecture

At the core of SettingsKitUI is the hierarchical router and composable rows.

### Routing
Wrap your settings in an and provide an array of ``SKPage`` models. 
Use the environment modifier to enforce a layout style, or leave it automatic.

### Building Blocks
Build out the content of your pages using standard components:
* ``SKList`` - The root wrapper for your sections.
* ``SKSection`` - A logical grouping for your rows.
* ``SKBaseRow`` - The fundamental layout primitive.

## Topics

### Views
- ``SKPage``
- ``SKSettingsStyle``

### Layouts
- ``SKList``
- ``SKForm``
- ``SKSection``

### Components
- ``SKBaseRow``
- ``SKActionRow``
- ``SKNavigationRow``
- ``SKToggleRow``
- ``SKPickerRow``

### Modifiers
- ``SKIconShape``
