# Pokemon-with-SwiftUI-Redux-MVVM

This is a simple, playground project where I will try to build a Pokedex app. This app will use the combine the following patterns and frameworks:
- [SwiftUI](https://developer.apple.com/xcode/swiftui/) (targeting iOS 14.0)
- [Redux](https://redux.js.org) for app state management
- [MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) as the main pattern

To ensure keeping a clean syntax, I will use `SwiftLint` as a dependency (the dependency manager being ~~Swift Package Manager~~ CocoaPods).

Every step will be documented in this file.

## Adding SwiftLint dependency

I was expecting to use Swift Package Manager to install `SwiftLint`, but this solution isn't available yet.

According to the `SwiftLint` documentation, I tried instead to use [Mint](https://github.com/yonaskolb/Mint), but I also got stuck with an issue that I was not able to solve: 

> Library not loaded: /usr/local/opt/openssl@1.1/lib/libssl.1.1.dylib
  Referenced from: /usr/local/Cellar/mint-lang/0.14.0/bin/mint
  Reason: tried: '/usr/local/opt/openssl@1.1/lib/libssl.1.1.dylib' (no such file), '/usr/local/lib/libssl.1.1.dylib' (no such file), '/usr/lib/libssl.1.1.dylib' (no such file)

I ended up using the good-old [CocoaPods](https://cocoapods.org/), initalizing it with `pod init`, then updating the Podfile to include `SwiftLint`'s dependency. Adding the expected Build Phase in Xcode and everything was running smooth. 

<img width="663" alt="Capture d’écran 2022-05-07 à 19 21 57" src="https://user-images.githubusercontent.com/25252204/167265035-0f2fedba-e013-4648-ada2-d0a43f6f2577.png">

Surprisingly, SwiftLint only threw one error, asking me to remove the underscores from the main `App` struct. 

## Coming next... Adding the Redux vibe to the project
