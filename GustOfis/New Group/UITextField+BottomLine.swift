//
//  UITextField+BottomLine.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 26/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func setDefaults(placeholderText:String, borderLineWidth:CGFloat, borderColor: UIColor = UIColor(red: 114/255, green: 113/255, blue: 143/255, alpha: 1.0)) {
        
        print("self.frame.height: \(self.frame.height)")
        
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
        
        self.borderStyle = UITextBorderStyle.none
        self.backgroundColor = UIColor.clear
        
        self.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                        attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        let borderLine = UIView()
        let height = 1.0
        borderLine.frame = CGRect(x: Double(self.layer.cornerRadius), y: Double(self.frame.height), width: Double(borderLineWidth), height: height)
        borderLine.backgroundColor = borderColor
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: self.layer.cornerRadius + 5, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = UITextFieldViewMode.always
        
        self.addSubview(borderLine)
    }
    
    func setAsUnfocused(borderColor: UIColor = UIColor(red: 114/255, green: 113/255, blue: 143/255, alpha: 1.0)) {
        self.subviews.first!.backgroundColor = borderColor
        self.backgroundColor = UIColor.clear
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!,
                                                        attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        self.textColor = UIColor.white
    }
    
    func setAsFocused() {
        self.subviews.first!.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.white
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!,
                                                        attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 114/255, green: 113/255, blue: 143/255, alpha: 1.0)])
        self.textColor = UIColor(red: 114/255, green: 113/255, blue: 143/255, alpha: 1.0)
    }
}
