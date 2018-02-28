//
//  GeoCacheItem.swift
//  TarneyHomework2
//
//  Created by Brandon Tarney on 2/26/18.
//  Copyright © 2018 Brandon Tarney. All rights reserved.
//

import UIKit
import MapKit

public enum geoCacheStatus {
    case FOUND
    case NOTFOUND
}
//TODO: I'm not sure this should inherit from MKAnnotation but instead should be a MKMapItem?! or CLLocation?
//TODO: need to write this information to user_defaults
public class GeoCacheItem: NSObject, MKAnnotation {
    
    //TODO: need image sanpshot value
    //TODO: need image representing geoCache (or string name anyway)
    public var title:String?
    public var locationName:String!
    public var coordinate: CLLocationCoordinate2D
    public var imagePath:String?
    public var found:geoCacheStatus?
    
    public init(title:String, locationName:String, coordinate: CLLocationCoordinate2D)
    {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        self.found = .NOTFOUND
        
        super.init()
    }
    
}

