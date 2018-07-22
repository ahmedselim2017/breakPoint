//
//  TxtGiris.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 14.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import UIKit

class TxtGiris: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib();
        gorunumleriAyarla();
    }
    

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x+20 , y: bounds.origin.y, width: bounds.size.width , height: bounds.size.width);

    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x+20 , y: bounds.origin.y, width: bounds.size.width , height: bounds.size.width);
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        var x=bounds;
        x.origin.x=x.origin.x+20;
        return x;
        
    }
    
    func gorunumleriAyarla(){
        let placeHolder=NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]);
        self.attributedPlaceholder=placeHolder;
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
