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
    private var _kullaniciEposta:String;
    private var _kullaniciId:String;
    
    var icerik:String{
        return _icerik;
    }
    
    var kullaniciEposta:String{
        return _kullaniciEposta;
    }
    
    var kullaniciId:String{
        return _kullaniciId;
    }
    
    init(icerik:String,kullaniciEposta:String,kullaniciId:String) {
        self._icerik=icerik;
        self._kullaniciEposta=kullaniciEposta;
        self._kullaniciId=kullaniciId;
    }
    
}
