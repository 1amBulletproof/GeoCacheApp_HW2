//
//  GeoCacheManager.swift
//  TarneyHomework2
//
//  Created by Brandon Tarney on 2/26/18.
//  Copyright © 2018 Brandon Tarney. All rights reserved.
//

import UIKit
import MapKit

public class GeoCacheManager: NSObject {
    
    public var geoCacheItems: [GeoCacheItem] = []
    public var sortedGeoCacheItems: [GeoCacheItem]?
    public var lastGeoCacheItemFound: GeoCacheItem?
    
    //TODO: use CoreLocation stuff to get distances?
    
    public override init() {}
    
    public func initializeGeoCacheItems() {
        
        let strangeLocation = CLLocation(latitude: 40.72909, longitude: -74.00057)
        let strangeGeoCache = GeoCacheItem(imagePath: "drStrange", title: "Dr. Strange", detail: "Sorcerer Supreme. Master of the mystical Arts. Wears a cape and crazy hair-do.",
                                           coordinate: CLLocationCoordinate2DMake(strangeLocation.coordinate.latitude, strangeLocation.coordinate.longitude))
        geoCacheItems.append(strangeGeoCache)

        let msMarvelLocation = CLLocation(latitude: 42.34903, longitude: -71.06644)
        let msMarvelGeoCache = GeoCacheItem(imagePath: "msMarvel", title: "Ms Marvel",  detail: "Ms Marvel, or Carol Danvers, packs a mean punch. If you are kree, make sure to avoid!",
                                           coordinate: CLLocationCoordinate2DMake(msMarvelLocation.coordinate.latitude, msMarvelLocation.coordinate.longitude))
        geoCacheItems.append(msMarvelGeoCache)

        let antManLocation = CLLocation(latitude: 25.718211, longitude: -80.2694)
        let antManGeoCache = GeoCacheItem(imagePath: "antMan", title: "Ant Man",  detail: "Pym can shrink to the size of ants, which is why he's called Ant-Man! Yeah, not the best name...",
                                           coordinate: CLLocationCoordinate2DMake(antManLocation.coordinate.latitude, antManLocation.coordinate.longitude))
        geoCacheItems.append(antManGeoCache)
        
        let ironManLocation = CLLocation(latitude: 34.00511, longitude: -118.80626)
        let ironManGeoCache = GeoCacheItem(imagePath: "ironMan", title: "Iron Man", detail: "Billionaire, philanthropist, playboy...and that's just when he's outside his suit of armor!",
                                           coordinate: CLLocationCoordinate2DMake(ironManLocation.coordinate.latitude, ironManLocation.coordinate.longitude))
        geoCacheItems.append(ironManGeoCache)
        
        let spiderManLocation = CLLocation(latitude: 40.71894, longitude: -73.84584)
        let spiderManGeoCache = GeoCacheItem(imagePath: "spiderMan", title: "Spider Man", detail: "He's just looking out for the little guy. His sense of style might be lame but his powers aren't!",
                                           coordinate: CLLocationCoordinate2DMake(spiderManLocation.coordinate.latitude, spiderManLocation.coordinate.longitude))
        geoCacheItems.append(spiderManGeoCache)
        
        let starLordLocation = CLLocation(latitude: 38.4364, longitude: -92.5197)
        let starLordGeoCache = GeoCacheItem(imagePath: "starLord", title: "Star-Lord", detail: "Mischevious, quick-witted, and always ready to party. Just don't take his mix-tape.",
                                           coordinate: CLLocationCoordinate2DMake(starLordLocation.coordinate.latitude, starLordLocation.coordinate.longitude))
        geoCacheItems.append(starLordGeoCache)
        
        let cptAmericaLocation = CLLocation(latitude: 40.653, longitude: -73.94432)
        let cptAmericaGeoCache = GeoCacheItem(imagePath: "cptAmerica", title: "Captain America", detail: "Just a kid from Brooklyn.",
                                           coordinate: CLLocationCoordinate2DMake(cptAmericaLocation.coordinate.latitude, cptAmericaLocation.coordinate.longitude))
        geoCacheItems.append(cptAmericaGeoCache)
        
        let hydraLocation = CLLocation(latitude: 38.88988, longitude: -77.00917)
        let hydraGeoCache = GeoCacheItem(imagePath: "hydra", title: "Hydra HQ", detail: "Big fan of facism and tax breaks. HAIL HYDRA!",
                                           coordinate: CLLocationCoordinate2DMake(hydraLocation.coordinate.latitude, hydraLocation.coordinate.longitude))
        geoCacheItems.append(hydraGeoCache)
        
        let killmongerLocation = CLLocation(latitude: 37.81021, longitude: -122.24357)
        let killmongerGeoCache = GeoCacheItem(imagePath: "killmonger", title: "Eric Killmonger", detail: "Has been waiting LITERALLY his whole life for this. Better hurry, he's known to burn the whole place down",
                                           coordinate: CLLocationCoordinate2DMake(killmongerLocation.coordinate.latitude, killmongerLocation.coordinate.longitude))
        geoCacheItems.append(killmongerGeoCache)
        
        let thanosLocation = CLLocation(latitude: 38.89767, longitude: -77.03657)
        let thanosGeoCache = GeoCacheItem(imagePath: "thanos", title: "Thanos", detail: "Hiding under copious amounts of bronzer, Thanos just wants to 'Make the Galaxy Great Again'",
                                           coordinate: CLLocationCoordinate2DMake(thanosLocation.coordinate.latitude, thanosLocation.coordinate.longitude))
        geoCacheItems.append(thanosGeoCache)
        
    }
    
    
    //Number of Items Found
    public func getNumberOfGeoCacheFound() -> Int {
        var count = 0
        for geoCache in self.geoCacheItems {
            if (geoCache.found == .FOUND) {
                count = count + 1
            }
        }
        return count
    }
    
    //Total Number of items
    public func getNumberOfGeoCacheItems() -> Int {
        return geoCacheItems.count
    }

    //Distance between two locationss
    public func getDistanceToCacheInMiles(_ givenLocation:CLLocation, _ cacheItem:GeoCacheItem) -> Double {
        let cacheLocation = CLLocation(coordinate: cacheItem.coordinate, altitude: 0.0, horizontalAccuracy: 1, verticalAccuracy: 1, timestamp: Date())
        return (givenLocation.distance(from: cacheLocation) / 1609.34)
    }
    
    
    public func setGeoCacheItemsSortedByDistance(givenLocation:CLLocation) {
        //Woo naive sorting
        self.sortedGeoCacheItems = self.geoCacheItems
        for item in 0..<10 {
            for idx in 1..<10 {
                if getDistanceToCacheInMiles(givenLocation, sortedGeoCacheItems![idx-1]) >
                    getDistanceToCacheInMiles(givenLocation, sortedGeoCacheItems![idx]) {
                    let geoCacheItem1 = sortedGeoCacheItems![idx-1]
                    let geoCacheItem2 = sortedGeoCacheItems![idx]
                    sortedGeoCacheItems![idx-1] = geoCacheItem2
                    sortedGeoCacheItems![idx] = geoCacheItem1
                }
            }
        }
    }
    
    //function that returns the items in distnace order
    public func getDistanceBetweenCoordinates(startCoordinate:CLLocationCoordinate2D, endCoordinate:CLLocationCoordinate2D) -> Double {
        let startCoordinate = MKMapPointForCoordinate(startCoordinate)
        let endCoordinate = MKMapPointForCoordinate(endCoordinate)
        let distanceBetweenCoordinates = MKMetersBetweenMapPoints(startCoordinate, endCoordinate)
        return distanceBetweenCoordinates.magnitude
    }
    
   
}

