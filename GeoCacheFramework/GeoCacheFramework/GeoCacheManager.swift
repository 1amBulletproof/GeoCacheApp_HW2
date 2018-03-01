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
    
    //TODO: use CoreLocation stuff to get distances?
    
    public override init() {}
    
    public func initializeGeoCacheItems() {
        
        let strangeLocation = CLLocation(latitude: 40.729098, longitude: -74.000577)
        let strangeGeoCache = GeoCacheItem(title: "Dr. Strange", detail: "Sorcerer Supreme. Master of the mystical Arts. Wears a cape and crazy hair-do.", locationName: "NYC Sanctum",
                                           coordinate: CLLocationCoordinate2DMake(strangeLocation.coordinate.latitude, strangeLocation.coordinate.longitude))
        geoCacheItems.append(strangeGeoCache)

        let msMarvelLocation = CLLocation(latitude: 42.349034, longitude: -71.066447)
        let msMarvelGeoCache = GeoCacheItem(title: "Ms Marvel",  detail: "Ms Marvel, or Carol Danvers, packs a mean punch. If you are kree, make sure to avoid!", locationName: "Boston",
                                           coordinate: CLLocationCoordinate2DMake(msMarvelLocation.coordinate.latitude, msMarvelLocation.coordinate.longitude))
        geoCacheItems.append(msMarvelGeoCache)

        let antManLocation = CLLocation(latitude: 25.718211, longitude: -80.2694)
        let antManGeoCache = GeoCacheItem(title: "Ant Man",  detail: "Pym can shrink to the size of ants, which is why he's called Ant-Man! Yeah, not the best name, but still pretty cool.", locationName: "Coral Gables, FL (probably jail)",
                                           coordinate: CLLocationCoordinate2DMake(antManLocation.coordinate.latitude, antManLocation.coordinate.longitude))
        geoCacheItems.append(antManGeoCache)
        
        let ironManLocation = CLLocation(latitude: 34.005115, longitude: -118.806265)
        let ironManGeoCache = GeoCacheItem(title: "Iron Man", detail: "Billionaire, philanthropist, playboy...and that's just when he's outside his suit of armor!", locationName: "Malibu w/Jarvis",
                                           coordinate: CLLocationCoordinate2DMake(ironManLocation.coordinate.latitude, ironManLocation.coordinate.longitude))
        geoCacheItems.append(ironManGeoCache)
        
        let spiderManLocation = CLLocation(latitude: 40.718940, longitude: -73.845849)
        let spiderManGeoCache = GeoCacheItem(title: "Spider Man", detail: "He's just looking out for the little guy. His sense of style might be lame but his powers aren't!", locationName: "Queens",
                                           coordinate: CLLocationCoordinate2DMake(spiderManLocation.coordinate.latitude, spiderManLocation.coordinate.longitude))
        geoCacheItems.append(spiderManGeoCache)
        
        let starLordLocation = CLLocation(latitude: 38.4, longitude: -92.5)
        let starLordGeoCache = GeoCacheItem(title: "Star-Lord", detail: "Mischevious, quick-witted, and always ready to party. Just don't take his mix-tape.", locationName: "Missouri",
                                           coordinate: CLLocationCoordinate2DMake(starLordLocation.coordinate.latitude, starLordLocation.coordinate.longitude))
        geoCacheItems.append(starLordGeoCache)
        
        let cptAmericaLocation = CLLocation(latitude: 40.6535, longitude: -73.944321)
        let cptAmericaGeoCache = GeoCacheItem(title: "Captain America", detail: "Just a kid from Brooklyn.", locationName: "Brooklyn",
                                           coordinate: CLLocationCoordinate2DMake(cptAmericaLocation.coordinate.latitude, cptAmericaLocation.coordinate.longitude))
        geoCacheItems.append(cptAmericaGeoCache)
        
        let hydraLocation = CLLocation(latitude: 38.889880, longitude: -77.009179)
        let hydraGeoCache = GeoCacheItem(title: "Hydra HQ", detail: "Big fan of facism and tax breaks. HAIL HYDRA!", locationName: "The Capitol Building",
                                           coordinate: CLLocationCoordinate2DMake(hydraLocation.coordinate.latitude, hydraLocation.coordinate.longitude))
        geoCacheItems.append(hydraGeoCache)
        
        let killmongerLocation = CLLocation(latitude: 37.810218, longitude: -122.243576)
        let killmongerGeoCache = GeoCacheItem(title: "Eric Killmonger", detail: "Has been waiting LITERALLY his whole life for this. Better hurry, he's known to burn the whole place down", locationName: "Oakland",
                                           coordinate: CLLocationCoordinate2DMake(killmongerLocation.coordinate.latitude, killmongerLocation.coordinate.longitude))
        geoCacheItems.append(killmongerGeoCache)
        
        let thanosLocation = CLLocation(latitude: 38.897676, longitude: -77.036573)
        let thanosGeoCache = GeoCacheItem(title: "Thanos", detail: "Hiding under copious amounts of bronzer, Thanos is mostly mis-understood and just wants to 'Make the Galaxy Great Again'", locationName: "The White House",
                                           coordinate: CLLocationCoordinate2DMake(thanosLocation.coordinate.latitude, thanosLocation.coordinate.longitude))
        geoCacheItems.append(thanosGeoCache)
        
    }
    
    public func getNumFound() -> Int {
        var count = 0
        for geoCache in self.geoCacheItems {
            if (geoCache.found == .FOUND) {
                count = count + 1
            }
        }
        return count
    }
    
    //function to set and/or get the discovered quality of the GeoCacheItem
    public func getStatus( forIndex: Int) -> GeoCacheStatus {
        return .NOTFOUND;
    }
    public func getStatus(forName:String) -> GeoCacheStatus {
        return .NOTFOUND;
    }
    
    public func setStatus( forIndex: Int, status:GeoCacheStatus) {

    }
    public func getStatus(forName:String, status:GeoCacheStatus) {

    }

    //function that returns the items in distnace order
    public func getDistanceToCache(myLocation:CLLocation, cacheLocation:CLLocation) -> Double {
        return 0.0
    }
    
   
}

