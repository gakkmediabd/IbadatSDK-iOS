# IbadatSDK-iOS

[![Version](https://img.shields.io/cocoapods/v/Ibadat-GP-SDK)](https://cocoapods.org/pods/Ibadat-GP-SDK)
[![License](https://img.shields.io/github/license/gakkmediabd/IbadatSDK-iOS)](https://github.com/gakkmediabd/IbadatSDK-iOS/blob/main/LICENSE)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%2010%2B-blue.svg)](#)
[![Languages](https://img.shields.io/badge/language-%20swift-FF69B4.svg?style=plastic)](#)
[![Code-Size](https://img.shields.io/github/languages/code-size/gakkmediabd/IbadatSDK-iOS)](#)
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

IbadatSDK-iOS is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Ibadat-GP-SDK'
```

## Uses

You can only present controller from here 

Present Surah 

```ruby
IbadatSdkCore.shared.openFeature(by: .SURAH, presentController: self)
```
Present Dua

```ruby
IbadatSdkCore.shared.openFeature(by: .DUA, presentController: self)
```
Present  Hadis

```ruby
IbadatSdkCore.shared.openFeature(by: .HADITH, presentController: self)
```
Present SALAT  Learning 

```ruby
IbadatSdkCore.shared.openFeature(by: .SALAT, presentController: self)
```
Present WALLPAPER

```ruby
IbadatSdkCore.shared.openFeature(by: .WALLPAPER, presentController: self)
```
Present COMPASS

```ruby
IbadatSdkCore.shared.openFeature(by: .COMPASS, presentController: self)
```
Present Islamic Calendar 

```ruby
IbadatSdkCore.shared.openFeature(by: .CALENDAR, presentController: self)
```
Present Salat Times

```ruby
IbadatSdkCore.shared.openFeature(by: .SALAT_TIME, presentController: self)
```
Present Ifter and Sehri time

```ruby
IbadatSdkCore.shared.openFeature(by: .IFTER_SEHRI, presentController: self)
```
Present TASBIH 

```ruby
IbadatSdkCore.shared.openFeature(by: .TASBIH, presentController: self)
```
Present LIVE VIDEO 

```ruby
IbadatSdkCore.shared.openFeature(by: .LIVE_VIDEO, presentController: self)
```
Present  NEARIST MOSQUE

```ruby
IbadatSdkCore.shared.openFeature(by: .NEARIST_MOSQUE, presentController: self)
```
Present  ZAKAT

```ruby
IbadatSdkCore.shared.openFeature(by: .ZAKAT, presentController: self)
```

## Permissions 

1. Location
2. Photo Library 

## Asset you need to added 

[`1. Azan (30s)`](https://github.com/gakkmediabd/IbadatSDK-iOS/blob/main/Ibadat-GP/azan.mp3)


## Author

MD Azizur Rahman, azizur.gakk@gmail.com

## License

IbadatSDK-iOS is available under the MIT license. See the LICENSE file for more info
