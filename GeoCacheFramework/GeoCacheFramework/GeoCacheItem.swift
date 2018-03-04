//
//  GeoCacheItem.swift
//  TarneyHomework2
//
//  Created by Brandon Tarney on 2/26/18.
//  Copyright © 2018 Brandon Tarney. All rights reserved.
//

import UIKit
import MapKit

public enum GeoCacheStatus {
    case FOUND
    case NOTFOUND
}
//TODO: I'm not sure this should inherit from MKAnnotation but instead should be a MKMapItem?! or CLLocation?
//TODO: need to write this information to user_defaults
public class GeoCacheItem: NSObject, MKAnnotation {
    
    //TODO: need image sanpshot value
    //TODO: need image representing geoCache (or string name anyway)
    public var title:String?
    public var detail:String?
    public var coordinate: CLLocationCoordinate2D
    public var imagePath:String = "alert_something_broke"
    public var found:GeoCacheStatus? {
        didSet {
            print("Write to user defaults here!")
        }
    }
    public var foundDate:String?
    {
        didSet {
            print("Write to user defaults here!")
        }
    }
    
    public init(imagePath:String, title:String, detail:String, coordinate: CLLocationCoordinate2D)
    {
        self.imagePath = imagePath
        self.title = title
        self.detail = detail
        self.coordinate = coordinate
        self.found = .NOTFOUND
        
        super.init()
    }
    
}

