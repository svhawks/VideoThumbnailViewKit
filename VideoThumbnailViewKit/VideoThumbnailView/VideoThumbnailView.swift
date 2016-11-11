//
//  VideoThumbnailView.swift
//  VideoThumbnailView
//
//  Created by Toygar Dundaralp on 9/29/15.
//  Copyright (c) 2015 Toygar Dundaralp. All rights reserved.
//

import UIKit
import AVFoundation

public protocol VideoThumbnailViewDelegate {
    func videoThumbnailViewGetImg(imgView:UIImage?) -> Void
}

open class VideoThumbnailView: UIView {
    var delegate:VideoThumbnailViewDelegate? = nil

    fileprivate var videoScroll = UIScrollView()
    fileprivate var thumImageView = UIImageView()
    fileprivate var arrThumbViews:[UIImageView] = []
    fileprivate var scrollContentWidth = 0.0
    fileprivate var videoURL = URL(string: "")
    fileprivate var videoDuration = 0.0
    fileprivate var activityIndicator = UIActivityIndicatorView()

    public init(frame: CGRect, videoURL url: URL, thumbImageWidth thumbWidth: Double) {
        super.init(frame: frame)
        self.videoURL = url
        self.videoDuration = self.getVideoTime(url)
        activityIndicator = UIActivityIndicatorView(
            frame: CGRect(
                x: self.center.x - 15,
                y: self.frame.size.height / 2 - 15,
                width: 30.0,
                height: 30.0))
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.startAnimating()
        addSubview(self.activityIndicator)

        videoScroll = UIScrollView(
            frame: CGRect(
                x: 0.0,
                y: 0.0,
                width: self.frame.size.width,
                height: self.frame.size.height))
        videoScroll.showsHorizontalScrollIndicator = false
        videoScroll.showsVerticalScrollIndicator = false
        videoScroll.bouncesZoom = false
        videoScroll.bounces = false
        self.addSubview(videoScroll)

        self.thumbImageProcessing(
            videoUrl: videoURL!,
            thumbWidth: thumbWidth) { (thumbImages, error) -> Void in
                print (thumbImages.count)
                self.delegate?.videoThumbnailViewGetImg(imgView: thumbImages.first?.image)
        }

        self.layer.masksToBounds = true
    }

    func handleTap(_ sender : UITapGestureRecognizer) {
        let imgView = sender.view as? UIImageView
        delegate?.videoThumbnailViewGetImg(imgView: imgView?.image)
    }

    fileprivate func thumbImageProcessing(
        videoUrl url: URL,
        thumbWidth: Double,
        completion: ((_ thumbImages: [UIImageView], _ error: NSError?) -> Void)?) {
        DispatchQueue.global(qos: .utility).async {
            for index in 0...Int(self.videoDuration) {
                let thumbXCoords = Double(index) * thumbWidth
                self.thumImageView = UIImageView(
                    frame: CGRect(
                        x: thumbXCoords,
                        y: 0.0,
                        width: thumbWidth,
                        height: Double(self.frame.size.height)))
                self.thumImageView.contentMode = .scaleAspectFit
                self.thumImageView.backgroundColor = UIColor.clear
                self.thumImageView.layer.borderColor = UIColor.gray.cgColor
                self.thumImageView.layer.borderWidth = 0.25
                self.thumImageView.tag = index

                let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(VideoThumbnailView.handleTap(_:)))
                tapGestureRecognizer.numberOfTapsRequired = 1;

                self.thumImageView.addGestureRecognizer(tapGestureRecognizer)
                self.thumImageView.isUserInteractionEnabled = true

                self.thumImageView.image = self.generateVideoThumbs(
                    self.videoURL!,
                    second: Double(index),
                    thumbWidth: thumbWidth)
                self.scrollContentWidth = self.scrollContentWidth + thumbWidth
                self.videoScroll.addSubview(self.thumImageView)
                self.videoScroll.sendSubview(toBack: self.thumImageView)
                if let imageView = self.thumImageView as UIImageView? {
                    self.arrThumbViews.append(imageView)
                }
                self.videoScroll.contentSize = CGSize(
                    width: Double(self.scrollContentWidth),
                    height: Double(self.frame.size.height))
            }
            self.videoScroll.contentSize = CGSize(
                width: Double(self.scrollContentWidth),
                height: Double(self.frame.size.height))
            self.activityIndicator.stopAnimating()
            completion?(self.arrThumbViews, nil)
            self.videoScroll.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
        }
    }

    fileprivate func getVideoTime(_ url: URL) -> Float64 {
        let videoTime = AVURLAsset(url: url, options: nil)
        return CMTimeGetSeconds(videoTime.duration)
    }

    fileprivate func generateVideoThumbs(_ url: URL, second: Float64, thumbWidth: Double) -> UIImage {
        let asset = AVURLAsset(url: url, options: nil)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.maximumSize = CGSize(width: thumbWidth, height: Double(self.frame.size.height))
        generator.appliesPreferredTrackTransform = false
        let thumbTime = CMTimeMakeWithSeconds(second, 1)
        do {
            let ref = try generator.copyCGImage(at: thumbTime, actualTime: nil)
            return UIImage(cgImage: ref)
        }catch {
            print(error)
        }
        return UIImage()
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
