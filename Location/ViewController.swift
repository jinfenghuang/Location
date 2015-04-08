//
//  ViewController.swift
//  Location
//
//  Created by Jinfeng Huang on 15/3/7.
//  Copyright (c) 2015年 Jinfeng Huang. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    var manager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 37.381086, -121.983934
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        var latitude: CLLocationDegrees = 37.381086
        var longitude: CLLocationDegrees = -121.983934
        
        var latDelta: CLLocationDegrees = 0.01
        var longDelta: CLLocationDegrees = 0.01
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: true)
        
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        // var latitude: CLLocationDegrees = 37.381086
        // var longitude: CLLocationDegrees = -121.983934
        
        var mylocation = locations[0] as CLLocation
        
        var latitude: CLLocationDegrees = mylocation.coordinate.latitude
        var longitude: CLLocationDegrees = mylocation.coordinate.longitude
        var latDelta: CLLocationDegrees = 0.005
        var longDelta: CLLocationDegrees = 0.005
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: true)
        
        CLGeocoder().reverseGeocodeLocation(mylocation, completionHandler: { (placemark, error) in
            var place = CLPlacemark(placemark: placemark[0] as CLPlacemark)
            self.address.text = "\(place.subThoroughfare)\(place.thoroughfare)\(place.subLocality)\(place.locality)\(place.subAdministrativeArea)\(place.administrativeArea)\(place.postalCode)\(place.country)"
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

