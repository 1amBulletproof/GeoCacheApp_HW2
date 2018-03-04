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
    
    let userDefaults = UserDefaults.init(suiteName: "group.edu.jhu.epp.spring2018.hw2")
    public var geoCacheItems: [GeoCacheItem] = []
    public var sortedGeoCacheItems: [GeoCacheItem] = []
    public let numberOfGeoCacheItems = 10
    public var lastGeoCacheItemFound: GeoCacheItem? {
        didSet {
            let idOfLastFound = lastGeoCacheItemFound!.id!
            userDefaults?.set(idOfLastFound, forKey: "lastGeoFoundId")
        }
    }

    public override init() {}
    
    public func initializeGeoCacheItems() {
        
        let strangeLocation = CLLocation(latitude: 40.72909, longitude: -74.00057)
        let strangeGeoCache = GeoCacheItem(id:1, imagePath: "drStrange", title: "Dr. Strange", detail: "Sorcerer Supreme. Master of the mystical Arts. Wears a cape and crazy hair-do.",
                                           coordinate: CLLocationCoordinate2DMake(strangeLocation.coordinate.latitude, strangeLocation.coordinate.longitude))
        geoCacheItems.append(strangeGeoCache)
        sortedGeoCacheItems.append(strangeGeoCache)

        let msMarvelLocation = CLLocation(latitude: 42.34903, longitude: -71.06644)
        let msMarvelGeoCache = GeoCacheItem(id:2, imagePath: "msMarvel", title: "Ms Marvel",  detail: "Ms Marvel, or Carol Danvers, packs a mean punch. If you are kree, make sure to avoid!",
                                           coordinate: CLLocationCoordinate2DMake(msMarvelLocation.coordinate.latitude, msMarvelLocation.coordinate.longitude))
        geoCacheItems.append(msMarvelGeoCache)
        sortedGeoCacheItems.append(msMarvelGeoCache)

        let antManLocation = CLLocation(latitude: 25.718211, longitude: -80.2694)
        let antManGeoCache = GeoCacheItem(id:3, imagePath: "antMan", title: "Ant Man",  detail: "Pym can shrink to the size of ants, which is why he's called Ant-Man! Yeah, not the best name...",
                                           coordinate: CLLocationCoordinate2DMake(antManLocation.coordinate.latitude, antManLocation.coordinate.longitude))
        geoCacheItems.append(antManGeoCache)
        sortedGeoCacheItems.append(antManGeoCache)
        
        let ironManLocation = CLLocation(latitude: 34.00511, longitude: -118.80626)
        let ironManGeoCache = GeoCacheItem(id:4, imagePath: "ironMan", title: "Iron Man", detail: "Billionaire, philanthropist, playboy...and that's just when he's outside his suit of armor!",
                                           coordinate: CLLocationCoordinate2DMake(ironManLocation.coordinate.latitude, ironManLocation.coordinate.longitude))
        geoCacheItems.append(ironManGeoCache)
        sortedGeoCacheItems.append(ironManGeoCache)
        
        let spiderManLocation = CLLocation(latitude: 40.71894, longitude: -73.84584)
        let spiderManGeoCache = GeoCacheItem(id:5, imagePath: "spiderMan", title: "Spider Man", detail: "He's just looking out for the little guy. His sense of style might be lame but his powers aren't!",
                                           coordinate: CLLocationCoordinate2DMake(spiderManLocation.coordinate.latitude, spiderManLocation.coordinate.longitude))
        geoCacheItems.append(spiderManGeoCache)
        sortedGeoCacheItems.append(spiderManGeoCache)
        
        let starLordLocation = CLLocation(latitude: 38.4364, longitude: -92.5197)
        let starLordGeoCache = GeoCacheItem(id:6, imagePath: "starLord", title: "Star-Lord", detail: "Mischevious, quick-witted, and always ready to party. Just don't take his mix-tape.",
                                           coordinate: CLLocationCoordinate2DMake(starLordLocation.coordinate.latitude, starLordLocation.coordinate.longitude))
        geoCacheItems.append(starLordGeoCache)
        sortedGeoCacheItems.append(starLordGeoCache)
        
        let cptAmericaLocation = CLLocation(latitude: 40.653, longitude: -73.94432)
        let cptAmericaGeoCache = GeoCacheItem(id:7, imagePath: "cptAmerica", title: "Captain America", detail: "Just a kid from Brooklyn.",
                                           coordinate: CLLocationCoordinate2DMake(cptAmericaLocation.coordinate.latitude, cptAmericaLocation.coordinate.longitude))
        geoCacheItems.append(cptAmericaGeoCache)
        sortedGeoCacheItems.append(cptAmericaGeoCache)
        
        let hydraLocation = CLLocation(latitude: 38.88988, longitude: -77.00917)
        let hydraGeoCache = GeoCacheItem(id:8, imagePath: "hydra", title: "Hydra HQ", detail: "Big fan of facism and tax breaks. HAIL HYDRA!",
                                           coordinate: CLLocationCoordinate2DMake(hydraLocation.coordinate.latitude, hydraLocation.coordinate.longitude))
        geoCacheItems.append(hydraGeoCache)
        sortedGeoCacheItems.append(hydraGeoCache)
        
        let killmongerLocation = CLLocation(latitude: 37.81021, longitude: -122.24357)
        let killmongerGeoCache = GeoCacheItem(id:9, imagePath: "killmonger", title: "Eric Killmonger", detail: "Has been waiting LITERALLY his whole life for this. Better hurry, he's known to burn the whole place down",
                                           coordinate: CLLocationCoordinate2DMake(killmongerLocation.coordinate.latitude, killmongerLocation.coordinate.longitude))
        geoCacheItems.append(killmongerGeoCache)
        sortedGeoCacheItems.append(killmongerGeoCache)
        
        let thanosLocation = CLLocation(latitude: 38.89767, longitude: -77.03657)
        let thanosGeoCache = GeoCacheItem(id:10, imagePath: "thanos", title: "Thanos", detail: "Hiding under copious amounts of bronzer, Thanos just wants to 'Make the Galaxy Great Again'",
                                           coordinate: CLLocationCoordinate2DMake(thanosLocation.coordinate.latitude, thanosLocation.coordinate.longitude))
        geoCacheItems.append(thanosGeoCache)
        sortedGeoCacheItems.append(thanosGeoCache)
        

    }
    
    //helper fcn: get a GeoCacheItem based on its title (simplifies storing user_defaults data etc)
    public func getGeoCacheItem(byTitle:String) -> GeoCacheItem {
        for geoCacheItem in geoCacheItems {
            if geoCacheItem.title! == byTitle {
                return geoCacheItem
            }
        }
        print("Couldn't find the right GeoCacheItem, so I'll return the first one I know about")
        return geoCacheItems[0]
    }
    
    //helper fcn: get a GeoCacheItem based on its title (simplifies storing user_defaults data etc)
    public func getGeoCacheItem(byId:Int) -> GeoCacheItem {
        for geoCacheItem in geoCacheItems {
            if geoCacheItem.id! == byId {
                return geoCacheItem
            }
        }
        print("Couldn't find the right GeoCacheItem, so I'll return the first one I know about")
        return geoCacheItems[0]
    }
    
    //helper fcn: get a GeoCacheItem based on its title (simplifies storing user_defaults data etc)
    public func getGeoCacheIndex(byTitle:String) -> Int {
        var count = 0
        for geoCacheItem in geoCacheItems {
            if geoCacheItem.title! == byTitle {
                return count
            }
            count += 1
        }
        print("Couldn't find the right GeoCacheItem, so I'll return the first one I know about")
        return 0
    }
    
    
    //Number of Items Found
    public func getNumberOfGeoCacheFound() -> Int {
        var count = 0
        for geoCache in self.geoCacheItems {
            if (geoCache.found == true) {
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
    
    
    //Sort the geo's by distance from a given location (presumably user location).
    public func sortGeoCacheItemsByDistance(givenLocation:CLLocation) {
        //Woo naive sorting
        for item in 0 ..< numberOfGeoCacheItems {
            for idx in 1 ..< numberOfGeoCacheItems {
                if getDistanceToCacheInMiles(givenLocation, sortedGeoCacheItems[idx-1]) >
                    getDistanceToCacheInMiles(givenLocation, sortedGeoCacheItems[idx]) {
                    let geoCacheItem1 = sortedGeoCacheItems[idx-1]
                    let geoCacheItem2 = sortedGeoCacheItems[idx]
                    sortedGeoCacheItems[idx-1] = geoCacheItem2
                    sortedGeoCacheItems[idx] = geoCacheItem1
                }
            }
        }
    }
    
    //Get the closest UNFOUND geo (for directions!)
    public func getClosestUnfoundGeoCache() -> GeoCacheItem {
        for idx in 0 ..< numberOfGeoCacheItems {
            if sortedGeoCacheItems[idx].found == false {
                return sortedGeoCacheItems[idx]
            }
        }
        return sortedGeoCacheItems[0] //default case
    }
   
}

