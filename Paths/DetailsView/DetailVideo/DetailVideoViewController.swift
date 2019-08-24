//
//  DetailVideoViewController.swift
//  Paths
//
//  Created by Bratt Neumayer on 6/24/18.
//  Copyright © 2018 Bratt Neumayer. All rights reserved.
//

import UIKit

class DetailVideoViewController: UIViewController {

    @IBOutlet weak var remoteVideoView: UIView!
    @IBOutlet weak var localVideoView: UIView!
    
    var agoraController: AgoraioController?
    
    var videos: [VideoCellModel]?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        if self.videos != nil {
            
            let videoCanvas = self.videos![0].agoraCanvas!
            
            videoCanvas.view = self.localVideoView
            videoCanvas.renderMode = .hidden
            
            self.agoraController!.agoraKit.setupLocalVideo(videoCanvas)
            
            
            
            let remoteCanvas = self.videos![1].agoraCanvas!
            
            remoteCanvas.view = self.remoteVideoView
            remoteCanvas.renderMode = .hidden
            
            self.agoraController!.agoraKit.setupRemoteVideo(remoteCanvas)
            
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }

}
