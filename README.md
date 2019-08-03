# Humidity
> Calculate absolute humidity and dew point from relative humidity and temperature

[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

## Features

- [x] Absulute Humidity (g/m3)
- [x] Dew Point (°C, °F)

## Requirements

- iOS 10.0+
- Xcode 10.2.1+

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `Humidity` by adding it to your `Podfile`:

```ruby
platform :ios, '10.0'
use_frameworks!
pod 'Humidity'
```

To get the full benefits import `Humidity` 

``` swift
import Humidity
```

## Usage example

```swift
import Humidity

let humidity = Humidity(c: 20, rh: 0.8)
print(humidity.ah) // prints absoulte humidity (g/m³)
print(humidity.Td) // prints dew point (°C)
print(humidity.TdF) // prints dew point (°F)

```

## Contribute

We would love you for the contribution to **Humidity**, check the ``LICENSE`` file for more info.

## Credits

[The IAPWS Formulation 1995 for the Thermodynamic Properties of Ordinary Water Substance for General and Scientific Use](https://doi.org/10.1063/1.1461829) 

## Meta

Rinat Enikeev – rinat.enikeev@gmail.com

Distributed under the BSD license. See ``LICENSE`` for more information.

[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-BSD-blue.svg
[license-url]: LICENSE
