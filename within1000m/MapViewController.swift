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
    
    
    let mapView: MKMapView = {
        let mv = MKMapView()
        mv.translatesAutoresizingMaskIntoConstraints = false
        return mv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        
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

