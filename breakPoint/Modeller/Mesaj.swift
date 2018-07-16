//
//  Mesaj.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 16.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import Foundation

class  Mesaj {
    private var _icerik:String;
    private var _kullaniciID:String;
    
    var icerik:String{
        return _icerik;
    }
    
    var kullaniciID:String{
        return _kullaniciID;
    }
    
    init(icerik:String,kullaniciID:String) {
        self._icerik=icerik;
        self._kullaniciID=kullaniciID;
    }
    
}
