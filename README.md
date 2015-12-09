TYBlurImage
=========
[![Build Status](http://img.shields.io/travis/luckytianyiyan/TYBlurImage/master.svg?style=flat)](https://travis-ci.org/luckytianyiyan/TYBlurImage)
[![Pod Version](http://img.shields.io/cocoapods/v/TYBlurImage.svg?style=flat)](http://cocoadocs.org/docsets/TYBlurImage/)
[![Pod Platform](http://img.shields.io/cocoapods/p/TYBlurImage.svg?style=flat)](http://cocoadocs.org/docsets/TYBlurImage/)
[![Pod License](http://img.shields.io/cocoapods/l/TYBlurImage.svg?style=flat)](https://www.apache.org/licenses/LICENSE-2.0.html)

An easy way to set up blur effect and play the animation.

## Example

### UIImageView Play Blur Aniamtion

![Play Aniamtion Example](https://raw.githubusercontent.com/luckytianyiyan/TYBlurImage/master/README-Res/BlurImageView.gif)

### UIImage Blur Effects

![Effect Example](https://raw.githubusercontent.com/luckytianyiyan/TYBlurImage/master/README-Res/BlurImage.gif)

## Installation

### Installation with CocoaPods


[CocoaPods](http://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries in your projects. See the [Get Started](http://cocoapods.org/#get_started) section for more details.

#### Podfile

Add the following to your Podfile.

```
pod 'TYBlurImage'
```

## CHANGELOG

### v1.1.0

#### Bug fixes

- Fix AssociationPolicy error

- Passively generate animation frames.

	Reference category will not affect the use of other UIImageView.

- When the frame data is not generated, the problem caused by the animation is played.

- image saturation mistake.

#### New features

- Add property downsampleBlurAnimationImage.

	Now you can choose whether to downsample the image.


## License

`TYBlurImage` is available under the MIT license. See the LICENSE file for more info.
