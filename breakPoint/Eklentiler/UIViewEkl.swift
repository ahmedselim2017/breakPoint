//
//  UIViewEkl.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 16.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import UIKit

extension UIView{
    func klavyeyeBaglan(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(klavyeDegisince(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil);
    }
    
    @objc func klavyeDegisince(_ bildirim:NSNotification){
        let sure=bildirim.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double;
        let sapma=bildirim.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt;
        
        let baslangicCercevesi=(bildirim.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue;
        let bitisCercevesi=(bildirim.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue;
        
        let deltaY=bitisCercevesi.origin.y-baslangicCercevesi.origin.y;
        
        UIView.animateKeyframes(withDuration: sure, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: sapma), animations: {
            self.frame.origin.y += deltaY;
        }, completion: nil);
    }
}


