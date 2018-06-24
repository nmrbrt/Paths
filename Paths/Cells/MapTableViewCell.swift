//
//  MapTableViewCell.swift
//  Paths
//
//  Created by Bratt Neumayer on 6/23/18.
//  Copyright © 2018 Bratt Neumayer. All rights reserved.
//

import UIKit
import MapKit

class MapTableViewCell: UITableViewCell {

    @IBOutlet weak var mapView: MKMapView!
    
    var mapRegion: MKCoordinateRegion!{
        
        didSet{
            
            self.mapView.setRegion(mapRegion, animated: true)
        }
    }
    
    var initialLocation: CLLocation{
        
        return CLLocation(latitude: 19.472645577495793, longitude: -155.07195019475682)//Hawaii
    }
    
    let regionRadius: CLLocationDistance = 36000
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.mapView.delegate = self
        
        self.mapRegion = MKCoordinateRegionMakeWithDistance(self.initialLocation.coordinate, regionRadius, regionRadius)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func bindWith(annotations: [LocationAnnotation]){
        
        for a in annotations{
            self.mapView.addAnnotation(a)
            
            self.mapView.setUserTrackingMode(.followWithHeading, animated: true)
        }
    }
}


extension MapTableViewCell: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            let pin = mapView.view(for: annotation) as? MKPinAnnotationView ?? MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            pin.pinTintColor = UIColor.purple
            return pin
            
        } else {
            // handle other annotations
            
        }
        
        guard let annotation = annotation as? LocationAnnotation else { return nil }
        
        
        
        let identifier = "marker"
        if #available(iOS 11.0, *) {
            var view: MKMarkerAnnotationView
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            return view
        } else {
            return nil
        }
    }
    
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        guard let annotation = view.annotation as? LocationAnnotation else { return }
        guard let id = annotation.id else {return}//handle this of course
        
    }
}
