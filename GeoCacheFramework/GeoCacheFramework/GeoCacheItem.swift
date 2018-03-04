//
//  GeoCacheItem.swift
//  TarneyHomework2
//
//  Created by Brandon Tarney on 2/26/18.
//  Copyright © 2018 Brandon Tarney. All rights reserved.
//

import UIKit
import MapKit

public class GeoCacheItem: NSObject, MKAnnotation {
    
    let userDefaults = UserDefaults.init(suiteName: "group.edu.jhu.epp.spring2018.hw2")
    public var id:Int?
    public var title:String?
    public var detail:String?
    public var coordinate: CLLocationCoordinate2D
    public var imagePath:String = "alert_something_broke"
    
    public var found:Bool {
        get {
            return userDefaults!.bool(forKey: "found\(self.id!)")
        }
        set (newFoundValue) {
            userDefaults!.set(newFoundValue, forKey: "found\(self.id!)")
            //If you are set to found, mark yourself as most recent item
            if (newFoundValue == true) {
                userDefaults!.set(self.id, forKey: "lastGeoFoundId")
            }
        }
    }
    
    public var foundDate:String {
        get {
            if let foundDate = userDefaults!.string(forKey: "foundDate\(self.id!)") {
                return foundDate
            } else {
                return "N/A"
            }
        }
        set (newFoundDate) {
            return userDefaults!.set(newFoundDate, forKey: "foundDate\(self.id!)")
        }
    }
    
    public init(id:Int, imagePath:String, title:String, detail:String, coordinate: CLLocationCoordinate2D)
    {
        self.coordinate = coordinate
        super.init()
        self.id = id
        self.imagePath = imagePath
        self.title = title
        self.detail = detail

    }
    
}

