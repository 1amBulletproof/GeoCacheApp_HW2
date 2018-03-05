//
//  TodayViewController.swift
//  GeocacheTodayExtension
//
//  Created by Brandon Tarney on 3/3/18.
//  Copyright © 2018 Brandon Tarney. All rights reserved.
//

import UIKit
import MapKit
import NotificationCenter
import GeoCacheFramework

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var lastFoundDateLabel: UILabel!
    @IBOutlet weak var lastFoundTitleLabel: UILabel!
    @IBOutlet weak var lastFoundImage: UIImageView!
    @IBOutlet weak var lastFoundSnapImage: UIButton!
    
    @IBOutlet weak var closestGeoTitleLabel1: UILabel!
    @IBOutlet weak var closestGeoDistance1: UILabel!
    @IBOutlet weak var closestGeoSnapImage1: UIButton!
    
    @IBOutlet weak var closestGeoTitleLabel2: UILabel!
    @IBOutlet weak var closestGeoDistance2: UILabel!
    @IBOutlet weak var closestGeoSnapImage2: UIButton!
    
    @IBOutlet weak var closestGeoTitleLabel3: UILabel!
    @IBOutlet weak var closestGeoDistance3: UILabel!
    @IBOutlet weak var closestGeoSnapImage3: UIButton!
    
    let expandedHeight = CGFloat(350.0)
    let mkMapView = MKMapView()
    
    let geoCacheManager = GeoCacheManager()
    let userDefaults = UserDefaults.init(suiteName: "group.edu.jhu.epp.spring2018.hw2")
    var userLocation:CLLocation? //user defaults info
    var lastFoundGeoCacheItem:GeoCacheItem? //user defaults info
    var geoCacheItem1 : GeoCacheItem?
    var geoCacheItem2 : GeoCacheItem?
    var geoCacheItem3 : GeoCacheItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded

        //Initialize GeoCacheItems
        geoCacheManager.initializeGeoCacheItems()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Default value, tho we stated the main app will always launch first, thus this value should ALWAYS be overwritten below
        self.userLocation = CLLocation(latitude: 39.16, longitude: -76.89)
        
        if let tmpLocationData = userDefaults?.data(forKey: "userLocation") {
            if let myLocation:CLLocation = NSKeyedUnarchiver.unarchiveObject(with: tmpLocationData) as? CLLocation {
                self.userLocation = myLocation
                print("User Location Read from Defaults is \(myLocation)")
            }
        }
        
        //Get nearest 3 items (using the current location)
        geoCacheManager.sortGeoCacheItemsByDistance(givenLocation: self.userLocation!)
        self.geoCacheItem1 = geoCacheManager.sortedGeoCacheItems[0]
        self.geoCacheItem2 = geoCacheManager.sortedGeoCacheItems[1]
        self.geoCacheItem3 = geoCacheManager.sortedGeoCacheItems[2]

        
        //Set UI componenets
        closestGeoTitleLabel1.text = geoCacheItem1!.title!
        closestGeoDistance1.text = String(Int(geoCacheManager.getDistanceToCacheInMiles(self.userLocation!, geoCacheItem1!)))
        self.requestSnapshotData(mapView: self.mkMapView,
                                 coordinate:(geoCacheItem1?.coordinate)!,
                                 image: self.closestGeoSnapImage1,
                                 completionHandler:
            {
                (mkMapSnapshot, error) in
                if let img = mkMapSnapshot?.image {
                    self.closestGeoSnapImage1.setImage(img, for: .normal)
                }
        } )
        
        closestGeoTitleLabel2.text = geoCacheItem2?.title!
        closestGeoDistance2.text = String(Int(geoCacheManager.getDistanceToCacheInMiles(self.userLocation!, geoCacheItem2!)))
        self.requestSnapshotData(mapView: self.mkMapView,
                                 coordinate:(geoCacheItem2?.coordinate)!,
                                 image: self.closestGeoSnapImage2,
                                 completionHandler:
            {
                (mkMapSnapshot, error) in
                if let img = mkMapSnapshot?.image {
                    self.closestGeoSnapImage2.setImage(img, for: .normal)
                }
        } )
        
        closestGeoTitleLabel3.text = geoCacheItem3?.title!
        closestGeoDistance3.text = String(Int(geoCacheManager.getDistanceToCacheInMiles(self.userLocation!, geoCacheItem3!)))
        self.requestSnapshotData(mapView: self.mkMapView,
                                 coordinate:(geoCacheItem3?.coordinate)!,
                                 image: self.closestGeoSnapImage3,
                                 completionHandler:
            {
                (mkMapSnapshot, error) in
                if let img = mkMapSnapshot?.image {
                    self.closestGeoSnapImage3.setImage(img, for: .normal)
                }
        } )
        
        //Last Geo Found
        let lastGeoFoundId = userDefaults!.integer(forKey: "lastGeoFoundId")
        if lastGeoFoundId != 0 { //0 is the default (invalid) id value
            print(lastGeoFoundId)
            self.lastFoundGeoCacheItem = geoCacheManager.getGeoCacheItem(byId: lastGeoFoundId)
        } else {
            print("Nothing found yet")
        }
        
        //Set UI components:
        if let lastFoundGeo = self.lastFoundGeoCacheItem {
            lastFoundDateLabel.text = lastFoundGeo.foundDate
            lastFoundTitleLabel.text = lastFoundGeo.title!
            lastFoundImage.image = UIImage(named: lastFoundGeo.imagePath)
            self.requestSnapshotData(mapView: self.mkMapView,
                                     coordinate: lastFoundGeo.coordinate,
                                     image: self.lastFoundSnapImage,
                                     completionHandler:
                {
                    (mkMapSnapshot, error) in
                    if let img = mkMapSnapshot?.image {
                        self.lastFoundSnapImage.setImage(img, for: .normal)
                    }
            } )
        } else {
            lastFoundDateLabel.text = "None"
            lastFoundTitleLabel.text = "None"
        }
        
    }
    
    
    //Set the size of widget
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        let expanded = activeDisplayMode == .expanded
        if (expanded) {
            self.preferredContentSize = CGSize(width:self.view.frame.size.width, height:expandedHeight)
        } else {
            self.preferredContentSize = maxSize
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    //SNAPSHOT
    func requestSnapshotData(mapView: MKMapView, coordinate: CLLocationCoordinate2D, image: UIView, completionHandler: @escaping (MKMapSnapshot?, Error?) -> ())
    {
        let snapShotOptions = MKMapSnapshotOptions()

        let widthInMeters = 1000
        let heightInMeters = 1000
        snapShotOptions.region = MKCoordinateRegionMakeWithDistance(
            coordinate,
            CLLocationDistance(widthInMeters),
            CLLocationDistance(heightInMeters))

        snapShotOptions.size = image.frame.size
        snapShotOptions.scale = UIScreen.main.scale

        //Get SnapShot
        let snapshotter = MKMapSnapshotter(options: snapShotOptions)

        //Use snapshot
        snapshotter.start(completionHandler: completionHandler)
    }
    
    
    //TODO: these each make a specifical URL callback
    @IBAction func lastGeoFoundButtonPressed(_ sender: Any) {
        self.sendUrlCallback(geoCacheId: lastFoundGeoCacheItem!.id! )
    }
    @IBAction func closestGeoButtonPressed1(_ sender: Any) {
//        self.sendUrlCallback(geoCacheTitle: self.geoCacheItem1!.title!)
        self.sendUrlCallback(geoCacheId: self.geoCacheItem1!.id!)
    }
    @IBAction func closestGeoButtonPressed2(_ sender: Any) {
//        self.sendUrlCallback(geoCacheTitle: self.geoCacheItem2!.title!)
                self.sendUrlCallback(geoCacheId: self.geoCacheItem2!.id!)
    }
    @IBAction func closestGeoButtonPressed3(_ sender: Any) {
//        self.sendUrlCallback(geoCacheTitle: self.geoCacheItem3!.title!)
                self.sendUrlCallback(geoCacheId: self.geoCacheItem3!.id!)
    }
    
 func sendUrlCallback(geoCacheId: Int) {
     let url = URL(string:("hw2://\(geoCacheId)"))
//    let url = URL(string:("hw2://BLAH"))
     self.extensionContext?.open(url!, completionHandler: {
        success in
            print("launch \(success)")})
    }
    
}
