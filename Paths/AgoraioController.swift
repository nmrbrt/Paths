//
//  AgoraioController.swift
//  Paths
//
//  Created by Bratt Neumayer on 6/23/18.
//  Copyright © 2018 Bratt Neumayer. All rights reserved.
//

import Foundation
import AgoraRtcEngineKit

class AgoraioController:NSObject, AgoraRtcEngineDelegate{
    
    var agoraKit: AgoraRtcEngineKit!
    
    var viewController: UIViewController?
    

    
    func initializeAgoraEngine(forViewController viewController: UIViewController) {
        
        self.viewController = viewController
        
        agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: "11a72e7053bb428981dbca501575c10b", delegate: self)
    }
    
    
    
    func setupVideo() {
        
        agoraKit.enableVideo()

        agoraKit.setVideoProfile(.portrait360P, swapWidthAndHeight: false)
    }
    
    
    
    func rtcEngine(_ engine: AgoraRtcEngineKit, firstRemoteVideoDecodedOfUid uid: UInt, size: CGSize, elapsed: Int) {
        
        guard let tempViewController = self.viewController as? ViewController else {return}
        
//        let newTempVideoCellModel = VideoCellModel()
        
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = uid
        videoCanvas.view = tempViewController.remoteVideoView
        videoCanvas.renderMode = .adaptive
        
        agoraKit.setupRemoteVideo(videoCanvas)
        
        
        
        
    }
    
    
    
    func rtcEngineMediaEngineDidLoaded(_ engine: AgoraRtcEngineKit) {
        
    }
    
    

}
