//
//  CircleView.swift
//  Gojek Contacts
//
//  Created by Faiz Umar Baraja on 25/11/2017.
//  Copyright © 2017 FaizBarajaApps. All rights reserved.
//

import UIKit

class CircleView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMoveToSuperview() {
        
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.size.width/2
        print ("view circle \(self.frame)")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
    */
    
}
