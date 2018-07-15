//
//  AuthServisi.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 14.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import Foundation;
import Firebase;

class AuthServisi{
    static let ornek=AuthServisi();
    
    func kullaniciKaydet(eposta:String,sifre:String,kullaniciKaydetmeBitis:@escaping(_ durum:Bool, _ hata:Error?)->()){
        Auth.auth().createUser(withEmail: eposta, password: sifre) { (kullanici, hata) in
            
            guard let kullanici = kullanici else{
                kullaniciKaydetmeBitis(false,hata);
                return;
            }
            
            let kullaniciVeri=["saglayici":kullanici.user.providerID,"eposta":kullanici.user.email];
            
            VeriServisi.ornek.VTKullaniciOlustur(id: kullanici.user.uid, kullaniciVeri: kullaniciVeri);
            kullaniciKaydetmeBitis(true,nil);

        }
    }
    
    func kullaniciGirisYap(eposta:String,sifre:String,kullaniciGirisBitis:@escaping(_ durum:Bool, _ hata:Error?)->()){
        Auth.auth().signIn(withEmail: eposta, password: sifre) { (kullanici, hata) in
            if hata != nil{
                kullaniciGirisBitis(false,hata);
                return;
            }
            kullaniciGirisBitis(true,nil);
        }
    }
    
}
