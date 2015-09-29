//
//  VideoThumbView.swift
//  VideoThumbView
//
//  Created by Toygar Dundaralp on 9/29/15.
//  Copyright (c) 2015 Toygar Dundaralp. All rights reserved.
//

import UIKit
import AVFoundation

public class VideoThumbView: UIView {
  
  private var videoScroll = UIScrollView()
  private var thumImageView = UIImageView()
  private var arrThumbViews = NSMutableArray()
  private var scrollContentWidth = 0.0
  private var videoURL = NSURL()
  private var videoDuration = 0.0
  private var activityIndicator = UIActivityIndicatorView()
  
  init(frame: CGRect, videoURL url: NSURL, thumbImageWidth thumbWidth: Double) {
    super.init(frame: frame)
    self.videoURL = url
    self.videoDuration = self.getVideoTime(url)
    activityIndicator = UIActivityIndicatorView(frame: CGRect(x: self.center.x - 15, y: self.frame.size.height / 2 - 15, width: 30.0, height: 30.0))
    activityIndicator.hidesWhenStopped = true
    activityIndicator.activityIndicatorViewStyle = .White
    activityIndicator.startAnimating()
    addSubview(self.activityIndicator)
    
    videoScroll = UIScrollView(frame: CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height))
    videoScroll.showsHorizontalScrollIndicator = false
    videoScroll.showsVerticalScrollIndicator = false
    videoScroll.bouncesZoom = false
    videoScroll.bounces = false
    self.addSubview(videoScroll)
    
    self.thumbImageProcessing(videoUrl: videoURL, thumbWidth: thumbWidth) { (thumbImages, error) -> Void in
      // println(thumbImages)
    }
    
    self.layer.masksToBounds = true
  }
  
  private func thumbImageProcessing(videoUrl url: NSURL, thumbWidth: Double, completion: ((thumbImages: NSMutableArray?, error: NSError?) -> Void)?) {
    let priority = DISPATCH_QUEUE_PRIORITY_HIGH
    dispatch_async(dispatch_get_global_queue(priority, 0)) {
      for index in 0...Int(self.videoDuration) {
        let thumbXCoords = Double(index) * thumbWidth
        self.thumImageView = UIImageView(frame: CGRect(x: thumbXCoords, y: 0.0, width: thumbWidth, height: Double(self.frame.size.height)))
        self.thumImageView.contentMode = .ScaleAspectFit
        self.thumImageView.backgroundColor = UIColor.clearColor()
        self.thumImageView.layer.borderColor = UIColor.grayColor().CGColor
        self.thumImageView.layer.borderWidth = 0.25
        self.thumImageView.tag = index
        self.thumImageView.image = self.generateVideoThumbs(self.videoURL, second: Double(index), thumbWidth: thumbWidth)
        self.scrollContentWidth = self.scrollContentWidth + thumbWidth
        self.videoScroll.addSubview(self.thumImageView)
        self.videoScroll.sendSubviewToBack(self.thumImageView)
        if let imageView = self.thumImageView as UIImageView? {
          self.arrThumbViews.addObject(imageView)
        }
      }
      self.videoScroll.contentSize = CGSize(width: Double(self.scrollContentWidth), height: Double(self.frame.size.height))
      self.activityIndicator.stopAnimating()
      completion?(thumbImages: self.arrThumbViews, error: nil)
      self.videoScroll.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
    }
  }
  
  private func getVideoTime(url: NSURL) -> Float64 {
    let videoTime = AVURLAsset(URL: url, options: nil)
    return CMTimeGetSeconds(videoTime.duration)
  }
  
  private func generateVideoThumbs(url: NSURL, second: Float64, thumbWidth: Double) -> UIImage {
    let asset = AVURLAsset(URL: url, options: nil)
    let generator = AVAssetImageGenerator(asset: asset)
    generator.maximumSize = CGSize(width: thumbWidth, height: Double(self.frame.size.height))
    generator.appliesPreferredTrackTransform = false
    let thumbTime = CMTimeMakeWithSeconds(second, 1)
    do {
    let ref = try generator.copyCGImageAtTime(thumbTime, actualTime: nil)
      return UIImage(CGImage: ref)
    }catch {
      print(error)
    }
    return UIImage()
  }
  
  required public init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
