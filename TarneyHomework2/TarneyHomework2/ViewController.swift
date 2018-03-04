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
    
    @IBOutlet weak var mkMapView: MKMapView!
    @IBOutlet weak var ratioFound: UILabel!
    @IBOutlet weak var nearestGeoCacheItem: UILabel!
    @IBOutlet weak var nearestGeoCacheDistance: UILabel!
    @IBOutlet weak var lastItemFound: UILabel!
    @IBOutlet weak var lastItemFoundDate: UILabel!
    
    let locationManager = CLLocationManager()
    let geoCacheManager:GeoCacheManager = GeoCacheManager()
    let regionRadius:CLLocationDistance = 1000.0
    
    var userLocation:CLLocation? {
        didSet {
            print("User Location Set")
            print("TODO: write to user defaults")
//            let userDefaults = UserDefaults.init(suiteName: "group.edu.jhu.epp.spring2018.hw2")

        }
    }
    var lastClosestGeo:GeoCacheItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        geoCacheManager.initializeGeoCacheItems()

        locationManager.requestWhenInUseAuthorization()
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse)
        {
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }

        mkMapView.delegate = self
        mkMapView.showsUserLocation = true

        for geoCache in geoCacheManager.geoCacheItems {
            mkMapView.addAnnotation(geoCache)
        }
        
    }
    
    //Set values whenever view will appear
    override func viewWillAppear(_ animated: Bool) {
        //Ratio Found
        let numberOfGeoCacheItems = String(geoCacheManager.getNumberOfGeoCacheItems())
        let numberFound = String(geoCacheManager.getNumberOfGeoCacheFound())
        let ratioText = "\(numberFound)/\(numberOfGeoCacheItems)"
        ratioFound.text = ratioText
        
        //Last Item Found:
        if let lastGeoCacheItem = geoCacheManager.lastGeoCacheItemFound {
            lastItemFound.text = lastGeoCacheItem.title!
            lastItemFoundDate.text = lastGeoCacheItem.foundDate
        }
        
        //Anytime the view is going to load (i.e. the only time a found state change is possible), get directions to closest UNFOUND geoCacheItem
        //Gaurd this so that we wait for userLocation to be valid!
        if let _ = self.userLocation {
            geoCacheManager.sortGeoCacheItemsByDistance(givenLocation: self.userLocation!)
            let closestGeoCacheItem = geoCacheManager.getClosestUnfoundGeoCache()
            if closestGeoCacheItem != lastClosestGeo {
                self.requestDirections(toCache: closestGeoCacheItem)
                self.lastClosestGeo = closestGeoCacheItem
            }
        }

    }
    
    
    //Update User Location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.userLocation = locations[locations.count - 1]
        geoCacheManager.sortGeoCacheItemsByDistance(givenLocation: self.userLocation!)
        nearestGeoCacheItem.text = geoCacheManager.sortedGeoCacheItems[0].title
        let distanceToNearestCache = Int(geoCacheManager.getDistanceToCacheInMiles(self.userLocation!, geoCacheManager.sortedGeoCacheItems[0]))
        nearestGeoCacheDistance.text = String(distanceToNearestCache)

        //Get Directions to the closest unfound geo cache item!
        //TODO: need to remove the old directions!?
        let closestGeoCacheItem = geoCacheManager.getClosestUnfoundGeoCache()
        self.requestDirections(toCache: closestGeoCacheItem)
        self.lastClosestGeo = closestGeoCacheItem

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    // Create Annotation (like button and/or lat/lon)
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        if let annotation = annotation as? GeoCacheItem
        {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
            {
                dequeuedView.annotation = annotation
                view = dequeuedView
                if (annotation.found == GeoCacheStatus.FOUND) {
                    view.pinTintColor = UIColor.green
                } else {
                    view.pinTintColor = UIColor.red
                }
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
    
    //Segue to detail view from annotation
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            performSegue(withIdentifier: "detailViewSegue", sender: view)
        }
    }

    //Setup DetailView Controller prior to Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailViewSegue") {
            if let nextViewController = segue.destination as? DetailViewController {
                let annotationView = sender as! MKPinAnnotationView
                nextViewController.geoCacheManager = geoCacheManager
                nextViewController.geoCacheItem = annotationView.annotation as? GeoCacheItem
                nextViewController.pinView = annotationView
                nextViewController.mapView = self.mkMapView
            }
        }
    }
    
    //Render overlays on the map
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline
        {
//            mapView.removeOverlays(mapView.overlays)
            let path = MKPolylineRenderer(overlay: overlay)
            path.strokeColor = UIColor.red.withAlphaComponent(0.5)
            path.lineWidth = 5;
            return path
        }
        return MKOverlayRenderer()
    }

    
    //Directions
    //TODO: Need to find a way to STOP rendering the previous direction line
    func requestDirections(toCache: GeoCacheItem) {
        let request = MKDirectionsRequest()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: self.userLocation!.coordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: toCache.coordinate))
        request.requestsAlternateRoutes = false
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate(completionHandler: {
            (response, error) in
            guard let error = error else {
                self.showRoute(response: response!)
                return
            }
        } )
    }
    
    //Add the lines to the map (blank out the last ones first!
    func showRoute(response: MKDirectionsResponse)
    {
        mkMapView.removeOverlays(mkMapView.overlays)
        for route in response.routes {
            self.mkMapView.add(route.polyline, level: .aboveRoads)
        }
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



     




 
 //    func centerMapOnLocation(location: CLLocation)
 //    {
 //        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius*2.0, regionRadius*2.0)
 //        mkMapView.setRegion(coordinateRegion, animated: true)
 //    }



 
 
 
 
 
 
 
 
 
 


