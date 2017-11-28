//
//  AlertView.swift
//  xiphiastecProject
//
//  Created by admin on 11/27/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit

// Custom Alert View

func showAlert(message : String, actions : [(title : String , style : UIAlertActionStyle, handler : ((UIAlertAction)->Void)?)] = [(title : LabelTexts.main.OK, style : .destructive, handler : nil)], type : UIAlertControllerStyle)->UIAlertController {
    
    let alertViewController = UIAlertController(title: "Youtube App", message: message, preferredStyle: type)
    
    for action in actions {
        alertViewController.addAction(UIAlertAction(title: action.title, style: action.style, handler: action.handler))
    }    
    
    return alertViewController
    
}


// Custom Activity Indicator

func showActivity(inView : UIView)->UIActivityIndicatorView{
    
    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    activityIndicatorView.color = .gray
    activityIndicatorView.hidesWhenStopped = true
    activityIndicatorView.center = CGPoint(x: inView.frame.width/2, y: inView.frame.height/2)
    activityIndicatorView.startAnimating()
    inView.addSubview(activityIndicatorView)
    return activityIndicatorView
    
}
