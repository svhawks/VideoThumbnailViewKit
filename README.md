[![Build Status](https://travis-ci.org/toygar/VideoThumbView.svg?branch=master)](https://travis-ci.org/toygar/VideoThumbView)

# VideoThumbView - Video Thumb ScrollView
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
pod "VideoThumbView"
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
