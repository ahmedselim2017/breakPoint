//
//  GolgeGorunusu.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 14.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import UIKit

class GolgeGorunusu: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib();
        gorunumleriAyarla();
    }
    
    func gorunumleriAyarla(){
        self.layer.shadowOpacity=0.75;
        self.layer.shadowRadius=5;
        self.layer.shadowColor=#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1);
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
