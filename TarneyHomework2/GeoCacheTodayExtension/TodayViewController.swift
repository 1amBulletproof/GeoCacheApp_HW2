//
//  TodayViewController.swift
//  GeocacheTodayExtension
//
//  Created by Brandon Tarney on 3/3/18.
//  Copyright © 2018 Brandon Tarney. All rights reserved.
//

import UIKit
import NotificationCenter
import GeoCacheFramework

class TodayViewController: UIViewController, NCWidgetProviding {
    
    let expandedHeight = CGFloat(350.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded

    }
    
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
    
/* HOW TO URL:
 func openButtonPressed(geoCacheID: Int) {
    print("opening app")
     let url = URL(string:("hw2://GEOCACHE_ID_OR_NAME")))
     print("url is \(url!)")
     self.extensionContext?.open(url!, completionHandler: {success in print("launch \(success)")})
    }
 */
    
}
