//
//  UIImageEkl.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 18.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import UIKit;

extension UIImage {
    func toString()->String{
        return (self.pngData()?.base64EncodedString())!;
    }
}

