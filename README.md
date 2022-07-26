# Display

**There are currently build issues that did not appear throughout two months of extensive testing**

**There is no documentation currently due to Luau types not being written**

**There are some features that are either implemented incorrectly, not implemented completely, or not implemented at all**

Display is a UI framework, built on top of [Fusion](https://github.com/Elttob/Fusion), and is meant to be a port of [Flutter](https://flutter.dev/) with additional tools that are useful for development on ROBLOX.

### Features

- [Application](https://api.flutter.dev/flutter/material/MaterialApp-class.html) for building the UI and reacting based on the Navigator
- [Pages](https://api.flutter.dev/flutter/widgets/Page-class.html) for the Navigator
- [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) that includes [States](https://pub.dev/packages/provider), [Themes](https://api.flutter.dev/flutter/material/Theme-class.html), [Navigator](https://api.flutter.dev/flutter/widgets/Navigator-class.html), Locale, and [Device Information](https://pub.dev/packages/flutter_device_type)
- Navigator supports arguments through a map of strings
- Navigator history for going to the initial build of the previous page
- CoreGui modifications for enabled and disabled components