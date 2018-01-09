//
//  Alerts.swift
//  LocalNotificationExample
//
//  Created by Sean Goldsborough on 1/6/18.
//  Copyright © 2018 Sean Goldsborough. All rights reserved.
//

import Foundation
import UIKit

class AlertView {
    

    class func alertMessage(view: UIViewController, title: String, message: String, numberOfButtons: Int, leftButtonTitle: String, leftButtonStyle: Int, rightButtonTitle: String, rightButtonStyle: Int) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: leftButtonTitle, style: UIAlertActionStyle(rawValue: leftButtonStyle)!, handler: nil))
        if numberOfButtons > 1 {
            alertController.addAction(UIAlertAction(title: rightButtonTitle, style: UIAlertActionStyle(rawValue: rightButtonStyle)!, handler: nil))
        }
        
        view.present(alertController, animated: true, completion: nil)
    }

}
