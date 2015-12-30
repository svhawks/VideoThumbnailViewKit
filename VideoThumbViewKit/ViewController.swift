//
//  ViewController.swift
//  VideoThumbnailView
//
//  Created by Toygar Dundaralp on 9/29/15.
//  Copyright © 2015 Toygar Dundaralp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    if let videoURL = NSURL.fileURLWithPath(
      NSBundle.mainBundle().pathForResource("Video", ofType: "mp4")!) as NSURL? {
        let rect = CGRect(x: 0.0, y: 70.0, width: self.view.frame.size.width, height: 100.0)
        let trimView = VideoThumbnailView(
          frame: rect,
          videoURL: videoURL,
          thumbImageWidth: 100.0)
        trimView.backgroundColor = UIColor.blackColor()
        view.addSubview(trimView)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
