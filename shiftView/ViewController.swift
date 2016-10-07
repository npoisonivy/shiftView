//
//  ViewController.swift
//  shiftView
//
//  Created by Nikki L on 10/6/16.
//  Copyright © 2016 Nikki. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var thisTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.thisTextField.delegate = self
        self.thisTextField.text = "Hello"
    }
    
    // when user tap the textfield, clear all the text
    func textFieldDidBeginEditing(textField: UITextField) {
        thisTextField.text = ""
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        thisTextField.resignFirstResponder()
        return true // does not hide the keyboard...IF you don't add "self.thisTextField.delegate = self" -> this adds current' view controller power that UITextField have! -> Then, u can call the delgate's func/ var!
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        subscribeToKeyboardNotifications2()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        unsubscribeFromKeyboardNotifications2()
    }
    // when keyboard shows, shift view up
    // 1. subscribe to keboard showing notification, and call 2. func
    // 2. func to calcluate view's frame - .frame.origin.y -= getKeyboardHeight
    // 3. geetKeyboardHeight - this to return KB's height from Notification's [User info] dictionary' key "UIKeyboard .... "
    // 4. unsubscribe to keboard showing notification
    
    // 1
    func subscribeToKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    // 2 - (1 triggers this func)
    
    func keyboardWillShow(notification: NSNotification){
        print(self.view.frame.origin.y)
        print(self.view.frame.origin.x)
        self.view.frame.origin.y -= getKeyboardHeight(notification)
        print("afterwards calculation, new view.frame.origin.y is \(self.view.frame.origin.y)")
        print("afterwards calculation, new view.frame.origin.y is \(self.view.frame.origin.x)")
    }
    
    // 3 - ( 2 asks for answer from this func)
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        print("keyboard size is \(keyboardSize.CGRectValue().height)")
        
        return keyboardSize.CGRectValue().height
    }
    
    // 4
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    // when keyboard is hidding, reset self.view.frame.orgin = 0
    // 1. subscribe to keyboardwillhide @ viewWillAppear , trigger 2's func
    // 2. set view's frame.origin.y = 0
    // 3. unsubscibe from keyboardwillhide @ viewWillDisappear
    
    // 1
    func subscribeToKeyboardNotifications2() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // 2
    func keyboardWillHide(notification: NSNotification) {
        // when this func got triggered, means keyboardwillhide
        self.view.frame.origin.y = 0
    }
    
    // 3 
    func unsubscribeFromKeyboardNotifications2() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }

}








