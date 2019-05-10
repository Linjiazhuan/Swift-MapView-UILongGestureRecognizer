//
//  ViewController.swift
//  MapDemo
//
//  Created by 林佳傳 on 2019/5/10.
//  Copyright © 2019 jiazhuan. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate , UIGestureRecognizerDelegate{

    
    
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView:MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        let longPressed = UILongPressGestureRecognizer(target: self, action: #selector(addPin(sender:)))
        longPressed.delegate = self
        //定義長案的時間
        longPressed.minimumPressDuration = 2
        
        view.addGestureRecognizer(longPressed)
    }
    
    @objc func addPin(sender:UILongPressGestureRecognizer){
        if sender.state == UIGestureRecognizer.State.began{
//            print("Pin added")
            let annotation = MKPointAnnotation()
            annotation.title = "My Pin"
            annotation.subtitle = "Pin Description"
            
            let touchPoint = sender.location(in: mapView)
            let locationCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            annotation.coordinate = locationCoordinate
            mapView.addAnnotation(annotation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = manager.location?.coordinate{
            let latDelta:CLLocationDegrees = 0.0018
            let logDelta:CLLocationDegrees = 0.0018
            
            let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: logDelta)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }


}

