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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
    
    func setupTableView(){
        
        self.detailsTableView.delegate = self
        self.detailsTableView.dataSource = self
        
        let videoCellNib = UINib(nibName: CellIdentifiers.map.rawValue, bundle: nil)
        self.detailsTableView.register(videoCellNib, forCellReuseIdentifier: CellIdentifiers.map.rawValue)
    }
    

}


extension DetailsViewController: UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        
        case 0:
            return UIScreen.main.bounds.height * 0.5
            
        default:
            return 0
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            guard self.annotations != nil else {break}
            (cell as! MapTableViewCell).bindWith(annotations: self.annotations!)
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
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.map.rawValue, for: indexPath)
            
        default:
            return UITableViewCell()
        }
    }
}



