//
//  VideoTableViewCell.swift
//  Paths
//
//  Created by Bratt Neumayer on 6/23/18.
//  Copyright © 2018 Bratt Neumayer. All rights reserved.
//

import UIKit
import AgoraRtcEngineKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var videoView: UIView!
    
    var agoraioController: AgoraioController?
    
    var isSetUp: Bool = false
    
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        DispatchQueue.main.async {
            self.shadowView.dropThinShadow()
            self.videoView.makeSquareWithCorner(size: .large, borderWidth: 0.0)
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    func bindWith(controller: AgoraioController){
        self.agoraioController = controller
    }
    
    
    //MARK: BIND
    
    func bindCellWithRemote(_ videoCanvas: AgoraRtcVideoCanvas){
        
        print("bindCellWithRemote - uid", videoCanvas.uid)
        
        guard self.agoraioController != nil else {return}

        if self.isSetUp{
            print("bindCellWithLocal")
            self.agoraioController!.agoraKit.muteRemoteVideoStream(videoCanvas.uid, mute: false)
            
        }else{
            
            videoCanvas.view = self.videoView
            videoCanvas.renderMode = .adaptive

            self.agoraioController!.agoraKit.setupRemoteVideo(videoCanvas)
            
            self.isSetUp = true
        }
        
    }
    
    
    
    func bindCellWithLocal(_ videoCanvas: AgoraRtcVideoCanvas){
        
        
        guard self.agoraioController != nil else {return}
        
        if self.isSetUp{
           print("bindCellWithLocal")
            self.agoraioController!.agoraKit.muteLocalVideoStream(false)
            
        }else{
        
            videoCanvas.view = self.videoView
            videoCanvas.renderMode = .adaptive
            
            self.agoraioController!.agoraKit.setupLocalVideo(videoCanvas)
            
            self.isSetUp = true
        }
    }
    
    
    //MARK: MUTE
    func muteRemoteVideo(_ videoCanvas: AgoraRtcVideoCanvas){
        
        
        guard self.agoraioController != nil else {return}
        
        self.agoraioController!.agoraKit.muteRemoteVideoStream(videoCanvas.uid, mute: true)
    }
    
    
    
    func muteLocalVideo(_ videoCanvas: AgoraRtcVideoCanvas){
        
        
        guard self.agoraioController != nil else {return}
        
        self.agoraioController!.agoraKit.muteLocalVideoStream(true)
    }
}
