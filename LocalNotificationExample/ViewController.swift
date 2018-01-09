//
//  VibrateButtonVC.swift
//  TouchIDExample
//
//  Created by Sean Goldsborough on 1/4/18.
//  Copyright © 2018 Sean Goldsborough. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox
import _SwiftUIKitOverlayShims
import UserNotifications

class ViewController: UIViewController {
    var i = 0
    
    @IBAction func vibeButton(_ sender: UIButton) {
        
        if userNameTF.text == "" || passwordTF.text == "" {
        sender.shake()
        userNameTF.shakeTF()
        passwordTF.shakeTF()
        //AudioServicesPlaySystemSound(1514)
        tapped()
        let timer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false) { (timer) in
            AlertView.alertMessage(view: self, title: "ERROR", message: "Invalid Credentials", numberOfButtons: 0, leftButtonTitle: "Try Again", leftButtonStyle: 0, rightButtonTitle: "", rightButtonStyle: 0)
        }
        } else {
            print("Credentials Are Valid")
        }
        
        let content = UNMutableNotificationContent()
        content.title = "LIMITED TIME OFFER"
        content.subtitle = "30% Off Immuno-boost IV Infusion"
        content.body = "Schedule your appointment today!"
        content.badge = 1
        //content.sound = UNNotificationSound.default()
        content.sound = UNNotificationSound(named: "CustomNotificationSound5.5.wav")
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: "timer done", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        AudioServicesPlaySystemSound(1521)
    }
    @IBOutlet weak var vibrateButton: UIButton!
    
    
    @IBOutlet weak var userNameTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    var keyboardIsShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTF?.delegate = self
        passwordTF?.delegate = self
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        
        generator.impactOccurred()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (didAllow, error) in
            if didAllow {
                print("user said yes")
            } else {
                print("user said no!")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToNotification(.UIKeyboardWillShow, selector: #selector(keyboardWillShow))
        subscribeToNotification(.UIKeyboardWillHide, selector: #selector(keyboardWillHide))
        subscribeToNotification(.UIKeyboardDidShow, selector: #selector(keyboardDidShow))
        subscribeToNotification(.UIKeyboardDidHide, selector: #selector(keyboardDidHide))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromAllNotifications()
    }
    
    
    
    
    @objc func tapped() {
        i += 1
        print("Running \(i)")
        
        switch i {
        case 1:
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(.error)
            AudioServicesPlaySystemSound(1517) // Actuate `Peek` feedback (weak boom)
            
        case 2:
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(.success)
            AudioServicesPlaySystemSound(1518) // Actuate `Pop` feedback (strong boom)
            
        case 3:
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(.warning)
            AudioServicesPlaySystemSound(1516) // Actuate `Nope` feedback (series of three weak booms)
            
            
        case 4:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.prepare()
            generator.impactOccurred()
            AudioServicesPlaySystemSound(1515) // Actuate `Peek` feedback (weak boom)
            
        case 5:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.prepare()
            generator.impactOccurred()
            AudioServicesPlaySystemSound(1519) // Actuate `Nope` feedback (series of three weak booms)
            AudioServicesPlaySystemSound(1520) // Actuate `Nope` feedback (series of three weak booms)
            
            
        case 6:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.prepare()
            generator.impactOccurred()
            AudioServicesPlaySystemSound(1521) // Actuate `Nope` feedback (series of three weak booms)
            
        case 7:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.prepare()
            generator.impactOccurred()
            AudioServicesPlaySystemSound(1521) // Actuate `Nope` feedback (series of three weak booms)
            
            
        default:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
            i = 0
        }
    }
}

extension UIButton {
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
}

extension UITextField {
    
    func shakeTF() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shakeTF")
    }
    
}


// MARK: - LoginVC: UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameTF?.resignFirstResponder()
        passwordTF?.resignFirstResponder()
        return true
    }
    
    
    //    // MARK: Show/Hide Keyboard
    //
    @objc func keyboardWillShow(_ notification: Notification) {
        if !keyboardIsShown {
            view.frame.origin.y = -keyboardHeight(notification) / 2.6
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if keyboardIsShown {
            view.frame.origin.y = 0
        }
    }
    
    @objc func keyboardDidShow(_ notification: Notification) {
        keyboardIsShown = true
    }
    
    @objc func keyboardDidHide(_ notification: Notification) {
        keyboardIsShown = false
    }
    
    func keyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = (notification as NSNotification).userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
}
// MARK: - LoginVC (Notifications)

private extension ViewController {
    
    func subscribeToNotification(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    func unsubscribeFromAllNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
}
