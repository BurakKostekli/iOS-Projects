//
//  ViewController.swift
//  Location
//
//  Created by Burak Köstekli on 7.12.2023.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var labelEnlem: UILabel!
    @IBOutlet weak var labelBoylam: UILabel!
    @IBOutlet weak var labelHiz: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        let konum = CLLocationCoordinate2D(latitude: 40.391438, longitude: 36.061573) // Elimizdeki map'in ortasındaki nokta neresi olsun
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) // Zoom
        let bölge = MKCoordinateRegion(center: konum, span: span)
        mapView.setRegion(bölge, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = konum // Bu konumda gözüksün
        pin.title = "Ev"
        pin.subtitle = "Fakirhane"
        mapView.addAnnotation(pin)
    }

}


extension ViewController : CLLocationManagerDelegate {
    
    // didUpdateLocations
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let sonKonum = locations[locations.count - 1]
        
        let enlem = sonKonum.coordinate.latitude
        let boylam = sonKonum.coordinate.longitude
        
        labelEnlem.text = "Enlem: \(enlem)"
        labelBoylam.text = "Boylam: \(boylam)"
        labelHiz.text = "Hız: \(sonKonum.speed)"
      
        
        let konum = CLLocationCoordinate2D(latitude: enlem, longitude: boylam)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let bölge = MKCoordinateRegion(center: konum, span: span)
        mapView.setRegion(bölge, animated: true)
        
        mapView.showsUserLocation = true
    }
}


