//
//  DetailViewController.swift
//  TarneyHomework2
//
//  Created by Brandon Tarney on 2/26/18.
//  Copyright © 2018 Brandon Tarney. All rights reserved.
//

import UIKit
import MapKit
import GeoCacheFramework

class DetailViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var geoCacheTitle: UILabel!
    @IBOutlet weak var geoCacheSnap: UIImageView!
    @IBOutlet weak var geoCacheLat: UILabel!
    @IBOutlet weak var geoCacheLon: UILabel!
    @IBOutlet weak var geoCacheDetail: UILabel!
    @IBOutlet weak var geoCacheImage: UIImageView!
    @IBOutlet weak var geoCacheFoundDate: UILabel!
    @IBOutlet weak var geoCacheSwitch: UISwitch!
    
    //TODO: Need to implement a back button!
    var geoCacheItem:GeoCacheItem?
    var mapView: MKMapView?
    var pinView:MKPinAnnotationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Request snapshot w/closure to set it to image
        self.requestSnapshotData(mapView: self.mapView!, completionHandler:
            {
                (mkMapSnapshot, error) in
                print("In completionHandler")
                if let image = mkMapSnapshot?.image {
                    print("Got a snapshot!")
                    self.geoCacheSnap.image = image
                }
            } )
        
        geoCacheTitle.text = geoCacheItem!.title
        geoCacheLat.text = geoCacheItem!.coordinate.latitude.description
        geoCacheLon.text = geoCacheItem!.coordinate.longitude.description
        geoCacheDetail.text = geoCacheItem!.detail

        geoCacheImage.image = UIImage(named: geoCacheItem!.imagePath)
        
        if geoCacheItem!.found == GeoCacheStatus.NOTFOUND {
            geoCacheSwitch.isOn = false;
            geoCacheFoundDate.text = "          "
        } else {
            setGeoCacheFoundDate( date:geoCacheItem!.foundDate!)
            geoCacheSwitch.isOn = true;
        }
        
        //TODO: snapshot here?
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("HOW ABOUT ME")
    }
    
    func setGeoCacheFoundDate(date:Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YYYY"
        let result = formatter.string(from: date)
        geoCacheFoundDate.text = result
    }

    @IBAction func geoCacheFound(_ sender: UISwitch) {
        if sender.isOn {
            geoCacheItem!.found = GeoCacheStatus.FOUND
            let date = Date()
            print(Date())
            geoCacheItem!.foundDate = date
            setGeoCacheFoundDate(date: date)
            pinView!.pinTintColor = .green
        } else {
            geoCacheItem!.found = GeoCacheStatus.NOTFOUND
            geoCacheFoundDate.text = "        "
            pinView!.pinTintColor = .red
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //TODO: prepareForSegue BACK to MainViewController ("ViewController")
    //- Allows updating the labels in the MainView for however many found
    //https://stackoverflow.com/questions/28788416/swift-prepareforsegue-with-navigation-controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }



/* SNAPSHOT Function - SHOULD JUST BE DONE MANUALLY FOR EACH LOCATION and STORED WITH GeoCache OR computed On-The-Fly on prepare_for_segue?!
 */
    func requestSnapshotData(mapView: MKMapView, completionHandler: @escaping (MKMapSnapshot?, Error?) -> ())
    {
        print("requestion a snapshot")
        let snapShotOptions = MKMapSnapshotOptions()

        let widthInMeters = 1000
        let heightInMeters = 1000
        snapShotOptions.region = MKCoordinateRegionMakeWithDistance(
                geoCacheItem!.coordinate,
                CLLocationDistance(widthInMeters),
                CLLocationDistance(heightInMeters))

        snapShotOptions.size = geoCacheSnap.frame.size
        snapShotOptions.scale = UIScreen.main.scale
 
        //Get SnapShot
        let snapshotter = MKMapSnapshotter(options: snapShotOptions)
        
        //Use snapshot
        snapshotter.start(completionHandler: completionHandler)
    }
 
}

