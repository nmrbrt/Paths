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
    
    var viewController: ViewController?
    

    
    func initializeAgoraEngine(forViewController viewController: ViewController) {
        
        self.viewController = viewController
        
        agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: "", delegate: self)
    }
    
    
    
    func setupVideo() {
        
        agoraKit.enableVideo()

        agoraKit.setVideoProfile(.portrait360P, swapWidthAndHeight: false)
        
    }
    
    
    var remoteVideoCanvases = [AgoraRtcVideoCanvas]()
    
    
    
    func rtcEngine(_ engine: AgoraRtcEngineKit, firstRemoteVideoDecodedOfUid uid: UInt, size: CGSize, elapsed: Int) {
        
        guard self.viewController != nil else {return}
        
        let videoCanvas = AgoraRtcVideoCanvas()
        
        print("firstRemoteVideoDecodedOfUid - uid:", uid)
        videoCanvas.uid = uid
        
        let newTempVideoCellModel = VideoCellModel(withCanvas: videoCanvas)
        
        self.viewController!.remoteVideoCells.append(newTempVideoCellModel)
        
        self.viewController!.insertVideoCell(atIndexPath: IndexPath(row: self.viewController!.remoteVideoCells.count - 1, section: 1))
        
    }
    
    
    func rtcEngineMediaEngineDidLoaded(_ engine: AgoraRtcEngineKit) {
        
    }
    
    

}
