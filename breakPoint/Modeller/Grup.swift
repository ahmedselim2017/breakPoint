//
//  Grup.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 18.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import Foundation;

class Grup{
    private var _grupBaslik:String;
    private var _grupAciklama:String;
    private var _anahtar:String;
    private var _katilimciSayisi:Int;
    private var _katilimcilar:[String];
    
    var grupBaslik:String{return _grupBaslik;}
    var grupAciklama:String{return _grupAciklama;}
    var anahtar:String{return _anahtar;}
    var katilimciSayisi:Int{return _katilimciSayisi;}
    var katilimcilar:[String]{return _katilimcilar;}

    init(baslik:String,aciklamma:String,anahtar:String,katilimciSayisi:Int,katilimcilar:[String]) {
        self._grupBaslik=baslik;
        self._grupAciklama=aciklamma;
        self._anahtar=anahtar;
        self._katilimciSayisi=katilimciSayisi;
        self._katilimcilar=katilimcilar;
    }
    
}
