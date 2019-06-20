//
//  RoundsButton.swift
//  Digipro
//
//  Created by Mauricio Rodriguez on 6/19/19.
//  Copyright © 2019 Mauricio Rodriguez. All rights reserved.
//

import UIKit

@IBDesignable

class RoundsButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
