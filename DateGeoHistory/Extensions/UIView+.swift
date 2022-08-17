//
//  UITextField+.swift
//  DateGeoHistory
//
//  Created by JUNO on 2022/08/17.
//

import UIKit

public extension UIView {
        
    func addBottomLineBorder(width: CGFloat){
        let bottomBorder = CALayer()
        bottomBorder.backgroundColor = UIColor.gray.cgColor
        bottomBorder.frame = CGRect(x: 0,
                                    y: self.frame.size.height + 5,
                                    width: self.frame.size.width,
                                    height: width
                                    )
        
        self.layer.addSublayer(bottomBorder)

    }
}
