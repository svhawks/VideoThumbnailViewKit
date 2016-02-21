
# VideoThumbnailViewKit - Video Thumbnail View

[![Build Status](https://img.shields.io/travis/movielala/VideoThumbnailViewKit/master.svg)](https://travis-ci.org/movielala/VideoThumbnailViewKit)
![License](https://img.shields.io/badge/license-MIT-blue.svg)
[![Dependencies](https://img.shields.io/badge/dependencies-none-brightgreen.svg)](https://github.com/mobileplayer/mobileplayer-ios)
[![Ready](https://badge.waffle.io/movielala/VideoThumbnailViewKit.png?label=Ready&title=Ready)](https://waffle.io/movielala/VideoThumbnailViewKit)
[![StackOverflow](https://img.shields.io/badge/StackOverflow-Ask%20a%20question!-blue.svg)](http://stackoverflow.com/questions/ask?tags=VideoThumbnailViewKit+ios+swift)
[![Join the chat at https://gitter.im/mobileplayer/mobileplayer-ios](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/movielala/VideoThumbnailViewKit)
[![CocoaPods](https://img.shields.io/cocoapods/v/VideoThumbnailViewKit.svg)](https://img.shields.io/cocoapods/v/VideoThumbnailViewKit.svg)


![alt tag](http://i60.tinypic.com/ma8g09.png)

##Introduction

__Requires iOS 8 or later and Xcode 6.1+__<br/>
 Swift support uses dynamic frameworks and is therefore only supported on iOS > 8.

##Installation

To install via CocoaPods add this line to your `Podfile`.

```
use_frameworks!
```
and
```
pod "VideoThumbViewKit"
```

Then, run the following command:

```$ pod install```

##Usage

```swift
let videoURL = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("Video", ofType: "mp4")!)!
let rect = CGRect(x: 0.0, y: 70.0, width: self.view.frame.size.width, height: 100.0)
var trimView = VideoThumbView(frame: rect, videoURL: videoURL, thumbImageWidth: 100)
trimView.backgroundColor = UIColor.blackColor()
view.addSubview(trimView)
```
