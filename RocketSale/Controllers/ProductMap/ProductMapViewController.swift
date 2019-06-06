//
//  ProductMapViewController.swift
//  RocketSale
//
//  Created by Ryan Luu on 6/5/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ProductMapViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    var products: [Product]?
    var annotations = [ProductAnnotation]()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        addProductAnnotations()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        centerMapOnLocation(location: locValue)
    }
    
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let regionRadius: CLLocationDistance = 10000
        let coordinateRegion = MKCoordinateRegion(center: location,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        print("lat: \(location.latitude)")
        print("lon: \(location.longitude)")
    }
    
    func addProductAnnotations() {
        convertProductsToAnnotations()
        mapView.addAnnotations(annotations)
    }
    
    func convertProductsToAnnotations() {
        let longitude = -122.408227
        let latitude = 37.7873589
        
        var annotation: ProductAnnotation?
        
        for product in products! {
            if product.latitude == 0 {
                annotation = ProductAnnotation.init(title: product.name!, price: product.price, subtitle: product.blurb!, coordinate: CLLocationCoordinate2D(latitude: latitude + Double.random(in: 0..<1), longitude: longitude + Double.random(in: 0..<1) ))
            } else {
                annotation = ProductAnnotation.init(title: product.name!, price: product.price, subtitle: product.blurb!, coordinate: CLLocationCoordinate2D(latitude: product.latitude, longitude: product.longitude ))
            }
            annotations.append(annotation!)
        }
    }
}
