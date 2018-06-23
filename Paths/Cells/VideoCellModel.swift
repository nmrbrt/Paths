//
//  VideoCellModel.swift
//  Paths
//
//  Created by Bratt Neumayer on 6/23/18.
//  Copyright © 2018 Bratt Neumayer. All rights reserved.
//

import Foundation
import UIKit
import AgoraRtcEngineKit

class VideoCellModel{
    
    var indexPath: IndexPath?
    var agoraCanvas: AgoraRtcVideoCanvas?
    
    var location: String?
    
    init(withCanvas canvas: AgoraRtcVideoCanvas) {
        self.agoraCanvas = canvas
    }
}
