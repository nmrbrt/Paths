//
//  ButtonTableViewCell.swift
//  Paths
//
//  Created by Bratt Neumayer on 6/24/18.
//  Copyright © 2018 Bratt Neumayer. All rights reserved.
//

import UIKit

enum ButtonType: String{
    case contact = "CONTACT"
    case signal = "SIGNAL SAFETY"
}

class ButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var mainButton: UIButton!
    
    var type: ButtonType?
    var detailsViewController: DetailsViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.shadowView.dropThinShadow()
        self.mainButton.makeSquareWithCorner(size: .large, borderWidth: 0.0)
        self.mainButton.addTarget(self, action: #selector(reactToButton), for: .touchUpInside)
        
        // Initialization code
    }
    
    
    @objc func reactToButton(){
        
        if self.type! == .contact {
            print("CONTACT_TAPPED")
            guard self.detailsViewController != nil else {return}
            print("CONTACT_TAPPED_2")
            guard self.detailsViewController!.videos.count > 0 else {return}
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "DetailVideoViewController") as! DetailVideoViewController
            viewController.videos = self.detailsViewController!.videos
            viewController.agoraController = self.detailsViewController!.agoraController!
            self.detailsViewController?.navigationController?.pushViewController(viewController, animated: true)
            print("CONTACT")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func bind(with something: Any?, for viewController: DetailsViewController){
        
        if let buttonType = something as? ButtonType{
         
            self.type = buttonType
            self.detailsViewController = viewController
            self.mainButton.setTitle(buttonType.rawValue, for: .normal)
        }
    }
    
    
    func setColor(to color: Int){
        self.shadowView.backgroundColor = UIColor(rgb: color)
    }
    
}
