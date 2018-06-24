//
//  DetailsViewController.swift
//  Paths
//
//  Created by Bratt Neumayer on 6/23/18.
//  Copyright © 2018 Bratt Neumayer. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var detailsTableView: UITableView!
    
    var annotations: [LocationAnnotation]?
    
    var videos = [VideoCellModel]()
    var agoraController: AgoraioController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ASDF",self.videos.count)

        setupTableView()
    }
    
    
    func setupTableView(){
        
        self.detailsTableView.delegate = self
        self.detailsTableView.dataSource = self
        
        let videoCellNib = UINib(nibName: CellIdentifiers.map.rawValue, bundle: nil)
        self.detailsTableView.register(videoCellNib, forCellReuseIdentifier: CellIdentifiers.map.rawValue)
        
        let buttonNib = UINib(nibName: CellIdentifiers.button.rawValue, bundle: nil)
        self.detailsTableView.register(buttonNib, forCellReuseIdentifier: CellIdentifiers.button.rawValue)
    }
    

}


extension DetailsViewController: UITableViewDelegate{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        
        case 0:
            return UIScreen.main.bounds.height * 0.5
            
        case 1,2:
            return 130
            
        default:
            return 0
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            guard self.annotations != nil else {break}
            (cell as! MapTableViewCell).bindWith(annotations: self.annotations!)
        case 1:
            (cell as! ButtonTableViewCell).bind(with: ButtonType.signal, for: self)
            (cell as! ButtonTableViewCell).setColor(to: 0x46735F)
            
        case 2:
            (cell as! ButtonTableViewCell).bind(with: ButtonType.contact, for: self)
            (cell as! ButtonTableViewCell).setColor(to: 0x094774)
        default:
            break
        }
    }
}


extension DetailsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        switch section {
        case 0:
            return 1
        case 1,2:
            return 1
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.map.rawValue, for: indexPath)
            
        case 1,2:
            return tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.button.rawValue, for: indexPath)
            
        default:
            return UITableViewCell()
        }
    }
}



