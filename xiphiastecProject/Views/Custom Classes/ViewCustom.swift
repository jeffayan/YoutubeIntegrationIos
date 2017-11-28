//
//  ImageViewCustom.swift
//  xiphiastecProject
//
//  Created by admin on 11/27/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit

@IBDesignable
class ViewCustom : UIView{
    
    @IBInspectable
    private var borderWidth : CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    private var borderColor : UIColor = .clear {
        didSet {
            self.layer.borderColor = self.borderColor.cgColor
        }
    }
    
}

