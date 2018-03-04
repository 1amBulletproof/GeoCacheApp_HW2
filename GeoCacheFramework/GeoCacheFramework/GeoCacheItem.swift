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

public class GeoCacheItem: NSObject, MKAnnotation {
    
    public var title:String?
    public var detail:String?
    public var coordinate: CLLocationCoordinate2D
    public var imagePath:String = "alert_something_broke"
    public var found:GeoCacheStatus?
    public var foundDate:String?
    
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

