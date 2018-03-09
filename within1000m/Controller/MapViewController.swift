//
//  ViewController.swift
//  within1000m
//
//  Created by 徐永宏 on 2018/3/8.
//  Copyright © 2018年 徐永宏. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    let managerHolder = ManagerHolder()
    
    // for show the map and the user location annotation node
    lazy var mapView: MKMapView = {
        let mv = MKMapView()
        mv.showsUserLocation = true
        mv.delegate = self
        mv.translatesAutoresizingMaskIntoConstraints = false
        return mv
    }()
    
    // computed property for retriving location manager in manager holder
    var locManager: CLLocationManager {
        return self.managerHolder.locManager
    }

    let REQ_ACC: CLLocationAccuracy = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up map view
        setupMapView()
        
        
        // set location manager's delegate
        locManager.delegate = self
        
        // request user location (may fail, depend on whether location access is permitted)
        self.managerHolder.checkForLocationAccess(always: true) {
            self.locManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locManager.distanceFilter = kCLDistanceFilterNone
            self.locManager.activityType = .other
            self.locManager.pausesLocationUpdatesAutomatically = false
//            self.locManager.startUpdatingLocation()
            // the location updating delegate will be called only once to pass the best result
            self.locManager.requestLocation()
        }
        
    }
    
    func setupMapView() {
        view.addSubview(mapView)
        // mapview constraints
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true

    }

}

let currentUserAnnotationId = "currentUserAnnotationId"

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let v = mapView.dequeueReusableAnnotationView(withIdentifier: currentUserAnnotationId) {
            return v
        } else {
            let v = MKAnnotationView(annotation: annotation, reuseIdentifier: currentUserAnnotationId)
            v.image = UIImage(named: "c_location")
            v.bounds.size = CGSize(width: 20, height: 20)
            return v
        }
        
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            self.managerHolder.doThisWhenAuthorized?()
            self.managerHolder.doThisWhenAuthorized = nil
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
//        let acc = location.horizontalAccuracy
//        print(acc)
//        if acc < 0 || acc > REQ_ACC {
//            return // wait for the next update
//        }
        let coord = location.coordinate
        print("You are at \(coord.latitude) \(coord.longitude)")
        
        // jump to the scurrent user's location on the map view
        let region = MKCoordinateRegionMakeWithDistance(coord, 1200, 1200)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}



