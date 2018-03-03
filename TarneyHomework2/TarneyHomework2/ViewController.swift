//
//  ViewController.swift
//  TarneyHomework2
//
//  Created by Brandon Tarney on 2/25/18.
//  Copyright © 2018 Brandon Tarney. All rights reserved.
//

import UIKit
import MapKit
import GeoCacheFramework

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    //*****FYI*******
    //MKMapItem = geographic location & interesting data for that location
    //Special MKMapItem represents user's location
    //MKMapItem openMap(with:launchOptions:) can be used to launch Maps, prepopulated with an array of MKMapItems (AKA GEOCACHE ITEMS?!)
    //MKAnnotationView can contain image label & disclosure button
        //-deque them
    //centerMapOnLocation(location: location)
    //MKDirectionsRequest between MKMap Items
    //MKMapSnapshotter generates an MKMapSnapshot based on the options
    //****************
    
    @IBOutlet weak var mkMapView: MKMapView!
    @IBOutlet weak var ratioFound: UILabel!
    @IBOutlet weak var nearestGeoCacheItem: UILabel!
    @IBOutlet weak var nearestGeoCacheDistance: UILabel!
    @IBOutlet weak var lastItemFound: UILabel!
    @IBOutlet weak var lastItemFoundDistance: UILabel!
    
    let locationManager = CLLocationManager()
    let geoCacheManager:GeoCacheManager = GeoCacheManager()
    let regionRadius:CLLocationDistance = 1000.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("WHAT ABOUT ME")
        
        geoCacheManager.initializeGeoCacheItems()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        mkMapView.delegate = self
        mkMapView.showsUserLocation = true
        locationManager.startUpdatingLocation()
        
        for geoCache in geoCacheManager.geoCacheItems {
            mkMapView.addAnnotation(geoCache)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //TODO: viewWillAppear:
        //1. geoCacheManager.getClosestUnfoundGeoCacheItem(myLocation)
        //2. get directions to this item
        //3. Update any UI necessary for found item using GeoCacheManager
    }
    
    ///* Current Location - necessary to find the nearest geoCache*/
    //    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //        let latestLocation = locations[locations.count - 1]
    //        print("lat = \(latestLocation.coordinate.latitude)")
    //        print("lon = \(latestLocation.coordinate.longitude)")
    //        print("alt = \(latestLocation.altitude)")
    //
    // /* DISTANCE CALC
    // let distanceBetween = latestLocation.distance(from: startLocation)
    // */
    //    }
    
    // ADD STUFF TO ANNOTATION (like button and/or lat/lon)
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        if let annotation = annotation as? GeoCacheItem
        {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
            {
                dequeuedView.annotation = annotation
                view = dequeuedView
//                print("reuse PIN")
//                if (annotation.found == GeoCacheStatus.FOUND) {
//                    view.pinTintColor = UIColor.green
//                } else {
//                    view.pinTintColor = UIColor.red
//                }
            }
            else
            {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                if (annotation.found == GeoCacheStatus.FOUND) {
                    view.pinTintColor = UIColor.green
                } else {
                    view.pinTintColor = UIColor.red
                }
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                view.leftCalloutAccessoryView = UILabel()
            }
            return view
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            performSegue(withIdentifier: "detailViewSegue", sender: view)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailViewSegue") {
            //case sender to GeoCacheItem!?
            if let nextViewController = segue.destination as? DetailViewController {
                let annotationView = sender as! MKPinAnnotationView
                nextViewController.geoCacheItem = annotationView.annotation as? GeoCacheItem
                nextViewController.pinView = annotationView
                nextViewController.mapView = self.mkMapView
                //TODO snapshot here?!
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

    
/*  DIRECTIONS
     request.source = MKMapItem(placemark: MKPlacemark(coordinate: building200Location.coordinate, addressDictionary: nil))
     request.destination = MKMapItem(placemark: MKPlacemark(coordinate: klobysLocation.coordinate, addressDictionary: nil))
     request.requestsAlternateRoutes = false
     request.transportType = .walking
 
     let directions = MKDirections(request: request)
     directions.calculate()
     {
            (response, error) in
        guard let error = error else { self.showRoute(response: response!); return }
     }
     func showRoute(response: MKDirectionsResponse)
        {
            for route in response.routes
        {
        mkView.add(route.polyline, level: .aboveRoads)
        }
     }
     
     func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline
        {
            let path = MKPolylineRenderer(overlay: overlay)
            path.strokeColor = UIColor.red.withAlphaComponent(0.5)
            path.lineWidth = 5;
            return path
        }
        return MKOverlayRenderer()
     }
 */



 
 //    func centerMapOnLocation(location: CLLocation)
 //    {
 //        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius*2.0, regionRadius*2.0)
 //        mkMapView.setRegion(coordinateRegion, animated: true)
 //    }



 
 
 
 
 
 
 
 
 
 


