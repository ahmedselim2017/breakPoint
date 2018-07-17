//
//  VeriServisi.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 13.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import Foundation;
import Firebase;
import FirebaseAuth;


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
    
    func feedPaylas(mesaj:String,kullaniciEposta:String,groupAnahtari:String?,sonuc:@escaping(_ durum:Bool)->()){
        if groupAnahtari != nil{
            
        }
        else{
            REF_FEEDLER.childByAutoId().updateChildValues(["icerik":mesaj,"kullaniciEposta":kullaniciEposta]);
            sonuc(true);
        }
    }
    
    
    func feedGetir(sonuc:@escaping (_ mesaj:[Mesaj])->()){
        var mesajlarDizisi=[Mesaj]();
        REF_FEEDLER.observeSingleEvent(of: .value) { (feedSnapshot) in
            guard let feedSnapshot = feedSnapshot.children.allObjects as?[DataSnapshot] else{return;}
            
            for mesaj in feedSnapshot{
                let icerik=mesaj.childSnapshot(forPath: "icerik").value as! String;
                let kullaniciEposta=mesaj.childSnapshot(forPath: "kullaniciEposta").value as! String;
                let sonMesaj=Mesaj(icerik: icerik, kullaniciEposta: kullaniciEposta);
                mesajlarDizisi.append(sonMesaj);
            }
            sonuc(mesajlarDizisi);
        }
    }
    

    func kullaniciCikisYap(sonuc:@escaping(_ durum:Bool,_ hata:Error?)->()){
        do{
            try Auth.auth().signOut();
            
            sonuc(true, nil);
        }
        catch{
            sonuc(false, Error.self as! Error);
        }
    }
    
    func emailGetir(sorgu:String, sonuc:@escaping(_ epostaDizi:[String])->()){
        var epostalar=[String]();
        REF_KULLANICILAR.observe(.value) { (snapshot) in
            guard let kullaniciSnapshot = snapshot.children.allObjects as? [DataSnapshot] else{return;}
            
            for kullanici in kullaniciSnapshot{
                let eposta=kullanici.childSnapshot(forPath: "eposta").value as? String;
                
                if (eposta?.contains(sorgu))! == true && eposta != Auth.auth().currentUser?.email{
                    debugPrint("BBBB")
                    epostalar.append(eposta!);
                    debugPrint("BURAYA\(epostalar.count)");
                }
            }
            sonuc(epostalar);
        }
    }
    
    func kullaniciIdGetir(epostalar:[String], sonuc:@escaping(_ idDizi:[String])->()){
        REF_KULLANICILAR.observeSingleEvent(of: .value) { (veriSnapshot) in
            var idDizi=[String]();
            guard let kullaniciSnapshot=veriSnapshot.children.allObjects as? [DataSnapshot] else{return;}
            for kullanici in kullaniciSnapshot{
                let eposta=kullanici.childSnapshot(forPath: "eposta").value as? String;
                if epostalar.contains(eposta!){
                    idDizi.append(kullanici.key);
                }
            }
            sonuc(idDizi);
        }
    }
    
    func grupOlustur(baslik:String,aciklama:String,kullaniciIdleri:[String],sonuc:@escaping (_ durum:Bool)->()){
        REF_GRUPLAR.childByAutoId().updateChildValues(["baslik":baslik,"aciklama":aciklama,"uyeler":kullaniciIdleri]);
        sonuc(true);
    }
    
}

