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

class DetailViewController: UIViewController {
    
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
    var pinView:MKPinAnnotationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        geoCacheTitle.text = geoCacheItem!.title
        geoCacheLat.text = geoCacheItem!.coordinate.latitude.description
        geoCacheLon.text = geoCacheItem!.coordinate.longitude.description
        geoCacheDetail.text = geoCacheItem!.detail
        
        if geoCacheItem!.found == GeoCacheStatus.NOTFOUND {
            geoCacheSwitch.isOn = false;
            geoCacheFoundDate.text = "          "
        } else {
            setGeoCacheFoundDate( date:geoCacheItem!.foundDate!)
            geoCacheSwitch.isOn = true;
        }
        
        //TODO: snapshot here?
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
