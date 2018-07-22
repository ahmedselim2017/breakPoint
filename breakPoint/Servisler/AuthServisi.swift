//
//  AuthServisi.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 14.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import Foundation;
import FBSDKLoginKit;
import Firebase;


class AuthServisi{
    static let ornek=AuthServisi();
    
    
  
    
    func kullaniciKaydet(eposta:String,sifre:String,kullaniciKaydetmeBitis:@escaping(_ durum:Bool, _ hata:Error?)->()){
        Auth.auth().createUser(withEmail: eposta, password: sifre) { (kullanici, hata) in
            
            guard let kullanici = kullanici else{
                kullaniciKaydetmeBitis(false,hata);
                
                return;
            }
            
            let kullaniciVeri=["saglayici":kullanici.user.providerID,"eposta":"anonim"];
            
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
    
    func kullaniciGirisYap(){
        Auth.auth().signInAnonymously { (sonuc, hata) in
            if hata != nil{
                debugPrint("HATA!!!");
            }
            guard let kullanici=sonuc else{return;}
            let kullaniciVeri=["saglayici":kullanici.user.providerID,"eposta":kullanici.user.email];
            
            VeriServisi.ornek.VTKullaniciOlustur(id: kullanici.user.uid, kullaniciVeri: kullaniciVeri);
            VeriServisi.ornek.profilResmiEkle(kullaniciId: kullanici.user.uid, resim: UIImage(named:"defaultProfileImage")!, sonuc: { (durum) in
                
            })
            
        }
    }
    
    func kullaniciGirisYap(viewController:UIViewController){
        let facebook=FBSDKLoginManager();
        facebook.logIn(withReadPermissions: ["public_profile","email"], from: viewController) { (sonuc, hata) in
            if hata != nil{
                debugPrint("facebook Girişi Başarısız");
                return;
            }
            guard let token=FBSDKAccessToken.current() else {return;}
            let kimlik=FacebookAuthProvider.credential(withAccessToken: token.tokenString);
            Auth.auth().signInAndRetrieveData(with: kimlik, completion: { (sonuc, hata) in
                if hata != nil{
                    debugPrint("facebook Girişi Başarısız2");
                    return;
                }
                guard let kullanici=sonuc else{return;}
                let kullaniciVeri=["saglayici":kullanici.user.providerID,"eposta":kullanici.user.email];
                
                VeriServisi.ornek.VTKullaniciOlustur(id: kullanici.user.uid, kullaniciVeri: kullaniciVeri);
                VeriServisi.ornek.profilResmiEkle(kullaniciId: kullanici.user.uid, resim: UIImage(named:"defaultProfileImage")!, sonuc: { (durum) in
                    
                })
               
                
            })
        }
    }
   
}
