//
//  ViewController.swift
//  Paths
//
//  Created by Bratt Neumayer on 6/23/18.
//  Copyright © 2018 Bratt Neumayer. All rights reserved.
//

import UIKit
import AgoraRtcEngineKit
import MapKit


enum CellIdentifiers: String {
    case video = "VideoTableViewCell"
    case map = "MapTableViewCell"
    case button = "ButtonTableViewCell"
}

class ViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapShadowView: UIView!
    @IBOutlet weak var mapVContainerView: UIView!
    
    
    var agoraioController = AgoraioController()
    
    var localVideos = [VideoCellModel]()
    var remoteVideoCells = [VideoCellModel]()
   
    var locations = [LocationAnnotation]()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setupTableView()
        
        self.appenAnnotations()
        
        self.agoraioController.initializeAgoraEngine(forViewController: self)
        
        self.agoraioController.setupVideo()
        
        self.setupLocalVideo()
        
        self.joinChannel()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//        tap.delegate = self // This is not required
        self.mapView.addGestureRecognizer(tap)
        
        self.mapShadowView.dropThinShadow()
        self.mapVContainerView.makeSquareWithCorner(size: .large, borderWidth: 0.0)
        
    }
    
    
    @objc func handleTap() {
        // handling code
        print("TAPPED")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.mainTableView.reloadData()
    }
    
    
    
    func appenAnnotations(){
        
        self.locations.append(LocationAnnotation(id: "001", title: "Marios", subtitle: "Cool as Sub-Zero", lat: 19.549017200459357, long: -155.0870563959287))
        
        self.locations.append(LocationAnnotation(id: "002", title: "Jon Snow", subtitle: "Hot as Scorpion", lat: 19.35118700532723, long: -155.11763954055175))
        
        self.locations.append(LocationAnnotation(id: "003", title: "Ygritte", subtitle: "Just got married", lat: 19.355721918020958, long: -155.18424415480956))
        
        
//
//        self.locations.append(LocationAnnotation(id: "003", title: "Brett", subtitle: "Just got married", lat: 19.455651226775256, long: -155.0137569879697))
        
        self.locations.append(LocationAnnotation(id: "003", title: "Sam", subtitle: "Just got married", lat: 19.49465465878744, long: -154.97478985540135))
        
        self.locations.append(LocationAnnotation(id: "003", title: "Gilly", subtitle: "Just got married", lat: 19.434446254452588, long: -154.95728039495214))
    }
    
    
    
    func setupTableView(){
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        
        let videoCellNib = UINib(nibName: CellIdentifiers.video.rawValue, bundle: nil)
        self.mainTableView.register(videoCellNib, forCellReuseIdentifier: CellIdentifiers.video.rawValue)
    }
    
    
    
    func setupLocalVideo() {
        
        let videoCanvas = AgoraRtcVideoCanvas()
        
        videoCanvas.uid = 0
        
        let localVideoModel = VideoCellModel(withCanvas: videoCanvas)
        
        self.localVideos.append(localVideoModel)
        
        let tempIndexPath = IndexPath(row: self.localVideos.count, section: 1)
        
        self.insertVideoCell(atIndexPath: tempIndexPath)
    }
    
    
    
    func joinChannel() {
        
        self.agoraioController.agoraKit.joinChannel(byToken: nil, channelId: "bnPaths", info:nil, uid:0) {[weak self] (sid, uid, elapsed) -> Void in
            
            
            if let weakSelf = self {
                
                weakSelf.agoraioController.agoraKit.disableAudio()
                
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

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    
//    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        switch indexPath.section {
//        case 0:
//            (cell as! VideoTableViewCell).muteLocalVideo(self.localVideos[indexPath.row].agoraCanvas!)
//            
//        case 1:
//            (cell as! VideoTableViewCell).muteRemoteVideo(self.remoteVideoCells[indexPath.row].agoraCanvas!)
//            
//        default:
//            break
//        }
//    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            (cell as! VideoTableViewCell).bindWith(controller: self.agoraioController)
            (cell as! VideoTableViewCell).bindCellWithLocal(self.localVideos[indexPath.row].agoraCanvas!)
        case 1:
            
            (cell as! VideoTableViewCell).bindWith(controller: self.agoraioController)
            (cell as! VideoTableViewCell).bindCellWithRemote(self.remoteVideoCells[indexPath.row].agoraCanvas!)
        default:
            break
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0,1:
            return 200
        default:
            return 0
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 1:
            
//            let selectedRemote = self.remoteVideoCells[indexPath.row]
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            
            if let detailsViewController = storyBoard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController{
                
                detailsViewController.annotations = self.locations
                detailsViewController.agoraController = self.agoraioController
                detailsViewController.videos.append(self.localVideos[0])
                detailsViewController.videos.append(self.remoteVideoCells[indexPath.row])
                
                self.navigationController?.pushViewController(detailsViewController, animated: true)
            }
            
        default:
            break
        }
    }
}


extension ViewController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.localVideos.count
        case 1:
            return self.remoteVideoCells.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0,1:
            
            return tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.video.rawValue, for: indexPath) as! VideoTableViewCell
            
        default:
            return UITableViewCell()
        }
    }
    
}


extension ViewController{
    
    func insertVideoCell(atIndexPath indexPath: IndexPath) {

        self.mainTableView.beginUpdates()
        self.mainTableView.insertRows(at: [indexPath], with: .automatic)
        self.mainTableView.endUpdates()
    }
}

