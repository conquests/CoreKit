//
//  VideoView.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2018. 03. 31..
//  Copyright © 2018. Tibor Bödecs. All rights reserved.
//

#if os(iOS)

import AVFoundation

//private var VideoViewStatusObservationContext = UInt8()

open class VideoView: View {
    
    override open class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    private var playerLayer: AVPlayerLayer {
        return self.layer as! AVPlayerLayer
    }

    public var player: AVPlayer? {
        get {
            return self.playerLayer.player
        }
        set {
            self.playerLayer.player = newValue
        }
    }

    public var isMuted: Bool = false {
        didSet {
            self.player?.isMuted = self.isMuted
        }
    }

    open override func initialize() {
        super.initialize()

        self.isUserInteractionEnabled = false
        self.playerLayer.videoGravity = .resizeAspectFill
    }

    public var localVideo: String? {
        didSet {
            guard let url = self.localVideo, let file = Bundle.main.url(forResource: url, withExtension: "mp4") else {
                return
            }
            let asset = AVURLAsset(url: file)
            
            let tracksKey = "tracks"
            asset.loadValuesAsynchronously(forKeys: [tracksKey]) { [unowned self] in
                let status = asset.statusOfValue(forKey: tracksKey, error: nil)
                guard status == .loaded else {
                    return
                }
                self.subscribeEndNotification()
                let item = AVPlayerItem(asset: asset)
//                item.addObserver(self.vid,
//                                 forKeyPath: "status",
//                                 options: .initial,
//                                 context: &VideoViewStatusObservationContext)

                let player = AVPlayer(playerItem: item)
                self.player = player
                self.player?.isMuted = self.isMuted
                self.player?.play()
            }
        }
    }

    public var remoteVideoUrl: String? {
        didSet {
            guard let urlString = self.remoteVideoUrl, let url = URL(string: urlString) else {
                return
            }
            self.subscribeEndNotification()
            let item = AVPlayerItem(url: url)
            let player = AVPlayer(playerItem: item)
            self.player = player
            self.player?.isMuted = self.isMuted
            self.player?.play()
        }
    }
    
    private func subscribeEndNotification() {
        let name = Notification.Name.AVPlayerItemDidPlayToEndTime
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.end(_:)),
                                               name: name,
                                               object: self.player?.currentItem)
    }
    
    deinit {
        let name = Notification.Name.AVPlayerItemDidPlayToEndTime
        NotificationCenter.default.removeObserver(self, name: name, object: self.player?.currentItem)
    }
    
    @objc func end(_ notification: NSNotification) {
        self.player?.seek(to: kCMTimeZero)
        self.player?.play()
    }
    
//    open override func observeValue(forKeyPath keyPath: String?,
//                                    of object: Any?,
//                                    change: [NSKeyValueChangeKey : Any]?,
//                                    context: UnsafeMutableRawPointer?) {
//        if context == &VideoViewStatusObservationContext {
//            //let status = (object as? AVPlayerItem)?.status
//            return
//        }
//        return super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
//    }

}
#endif
