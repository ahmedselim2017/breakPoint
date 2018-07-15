//
//  VeriServisi.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 13.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import Foundation;
import Firebase;

let VT_TEMEL=Database.database().reference();

class VeriServisi{
    static let ornek=VeriServisi();
    
    private var _REF_TEMEL=VT_TEMEL;
    private var _REF_KULLANICILAE=VT_TEMEL.child("kullanicilar");
    private var _REF_GRUPLAR=VT_TEMEL.child("gruplar");
    private var _REF_FEEDLER=VT_TEMEL.child("feedler");
    
    var REF_TEMEL:DatabaseReference{
        return _REF_TEMEL;
    }
    
    var REF_KULLANICILAR:DatabaseReference{
        return _REF_KULLANICILAE;
    }
    
    var REF_GRUPLAR:DatabaseReference{
        return _REF_GRUPLAR;
    }
    var REF_FEEDLER:DatabaseReference{
        return _REF_FEEDLER;
    }
    
    func VTKullaniciOlustur(id:String,kullaniciVeri:Dictionary<String,Any>){
        REF_KULLANICILAR.child(id).updateChildValues(kullaniciVeri);
        
    }
    
}
