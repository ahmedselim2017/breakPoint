//
//  YuvarlakResim.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 18.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import UIKit

class YuvarlakResim: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib();
        gorunumleriAyarla();
    }
    
    func gorunumleriAyarla(){
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = #colorLiteral(red: 0.3230867386, green: 0.3421254754, blue: 0.3874129653, alpha: 1);
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
