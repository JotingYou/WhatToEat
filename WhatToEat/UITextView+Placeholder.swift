//
//  UITextView+Placeholder.swift
//  WhatToEat
//
//  Created by joting on 2020/9/14.
//  Copyright © 2020 Joting. All rights reserved.
//

import UIKit

extension UITextView{
    
    func setPlaceholder(_ str:String,_ color:UIColor){
        let plabel = UILabel()
        plabel.text = str
        plabel.numberOfLines = 0
        plabel.textColor = color
        plabel.font = self.font
        plabel.sizeToFit()
        
        let HKVersion = Float(UIDevice.current.systemVersion)
        
        if HKVersion! >= 8.3 {
            //防止重复
            if self.value(forKey: "_placeholderLabel") != nil{
                return
            }
            self.addSubview(plabel)
            self.setValue(plabel, forKey: "_placeholderLabel")
        }

    }
}
