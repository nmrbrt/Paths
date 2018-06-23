//
//  ViewController.swift
//  Paths
//
//  Created by Bratt Neumayer on 6/23/18.
//  Copyright © 2018 Bratt Neumayer. All rights reserved.
//

import UIKit
import AgoraRtcEngineKit


enum CellIdentifiers: String {
    case video = "VideoTableViewCell"
}

class ViewController: UIViewController {

    @IBOutlet weak var videosContainerView: UIView!
    
    @IBOutlet weak var localVideoShadowView: UIView!
    @IBOutlet weak var localVideoView: UIView!
    
    @IBOutlet weak var remoteVideoShadowView: UIView!
    @IBOutlet weak var remoteVideoView: UIView!
    
    @IBOutlet weak var mainTableView: UITableView!
    
    
    var agoraioController = AgoraioController()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setupVideoViews()
        
        self.agoraioController.initializeAgoraEngine(forViewController: self)
        
        self.agoraioController.setupVideo()
        
        self.setupLocalVideo()
        
        self.joinChannel()
    }
    
    
    
    func setupVideoViews(){
        
        self.localVideoShadowView.dropThinShadow()
        self.remoteVideoShadowView.dropThinShadow()
        
        self.localVideoView.makeSquareWithCorner(size: .large, borderWidth: 0.0)
        self.remoteVideoView.makeSquareWithCorner(size: .large, borderWidth: 0.0)
    }
    
    
    
    func setupLocalVideo() {
        
        let videoCanvas = AgoraRtcVideoCanvas()
        
        videoCanvas.uid = 0
        videoCanvas.view = localVideoView
        videoCanvas.renderMode = .adaptive
        
        
        self.agoraioController.agoraKit.setupLocalVideo(videoCanvas)
        
        print("DONESKI")
    }
    
    
    
    func joinChannel() {
        
        self.agoraioController.agoraKit.joinChannel(byToken: nil, channelId: "bnPaths", info:nil, uid:0) {[weak self] (sid, uid, elapsed) -> Void in
            
            
            if let weakSelf = self {
                
                weakSelf.agoraioController.agoraKit.setEnableSpeakerphone(true)
                
                UIApplication.shared.isIdleTimerDisabled = true
                
                print("THIS_IS_GOUD")
            }
        }
    }

    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }


}



extension ViewController: UITableViewDelegate{

}


extension ViewController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let tempCell =  tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.video.rawValue, for: indexPath) as! VideoTableViewCell
            return tempCell
        default:
            return UITableViewCell()
        }
    }
    
}


extension ViewController{
    
    func insertVideoCell() {
        
        self.mainTableView.beginUpdates()
        self.mainTableView.insertRowsAtIndexPaths([NSIndexPath(forRow: Yourarray.count-1, inSection: 0)], withRowAnimation: .Automatic)
        self.mainTableView.endUpdates()
    }
}

