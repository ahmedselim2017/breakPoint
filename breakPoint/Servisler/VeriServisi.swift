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
    
    func profilResmiGetir(kullaniciId:String, sonuc:@escaping(_ resim:UIImage)->()){
        var profilResmi:UIImage!;
        REF_KULLANICILAR.child(kullaniciId).child("resim").observeSingleEvent(of: .value) { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else{sonuc(UIImage(named:"defaultProfileImage")!);return;}
            for resim in snapshot{
                let base64String=resim.value as? String;
                let base64Data=Data(base64Encoded:base64String!);
                profilResmi=UIImage(data: base64Data!);
                
            }
            sonuc(profilResmi);
        }
        
        
    }
    
    
    func profilResmiEkle(kullaniciId:String,resim:UIImage , sonuc:@escaping(_ durum:Bool)->()){
        REF_KULLANICILAR.child(kullaniciId).child("resim").updateChildValues(["base64":resim.jpegData(compressionQuality: 0.30)?.base64EncodedString()]);
        sonuc(true);
    }
    
    func feedPaylas(mesaj:String,kullaniciEposta:String,grupAnahtari:String?,kullaniciId:String,sonuc:@escaping(_ durum:Bool)->()){
        if grupAnahtari != nil{
            REF_GRUPLAR.child(grupAnahtari!).child("mesajlar").childByAutoId().updateChildValues(["icerik":mesaj,"kullaniciEposta":kullaniciEposta,"kullaniciId":kullaniciId]);
            sonuc(true);
        }
        else{
            REF_FEEDLER.childByAutoId().updateChildValues(["icerik":mesaj,"kullaniciEposta":kullaniciEposta,"kullaniciId":kullaniciId]);
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
                let kullaniciId=mesaj.childSnapshot(forPath: "kullaniciId").value as! String;
                
                let sonMesaj=Mesaj(icerik: icerik, kullaniciEposta: kullaniciEposta, kullaniciId: kullaniciId);
                mesajlarDizisi.append(sonMesaj);
            }
            sonuc(mesajlarDizisi);
        }
    }
    
    func kullaniciFeedGerit(eposta:String,sonuc:@escaping(_ mesaj:[Mesaj])->()){
        var mesajlarDizisi=[Mesaj]();
        REF_FEEDLER.observeSingleEvent(of: .value) { (feedSnapshot) in
            guard let feedSnapshot = feedSnapshot.children.allObjects as?[DataSnapshot] else{return;}
            
            for mesaj in feedSnapshot{
                let icerik=mesaj.childSnapshot(forPath: "icerik").value as! String;
                let kullaniciEposta=mesaj.childSnapshot(forPath: "kullaniciEposta").value as! String;
                let kullaniciId=mesaj.childSnapshot(forPath: "kullaniciId").value as! String;
                
                let sonMesaj=Mesaj(icerik: icerik, kullaniciEposta: kullaniciEposta, kullaniciId: kullaniciId);
                mesajlarDizisi.append(sonMesaj);
            }
            sonuc(mesajlarDizisi);
        }
    }
    
    func grupFeedleriniGetir(grup:Grup, sonuc:@escaping(_ mesajlar:[Mesaj])->()){
        var mesajDizi=[Mesaj]();
        REF_GRUPLAR.child(grup.anahtar).child("mesajlar").observeSingleEvent(of: .value) { (mesajSnapshot) in
            guard let mesajSnapshot = mesajSnapshot.children.allObjects as? [DataSnapshot] else{return;}
    
            for mesaj in mesajSnapshot{
                let icerik=mesaj.childSnapshot(forPath: "icerik").value as? String;
                let kullaniciEposta=mesaj.childSnapshot(forPath: "kullaniciEposta").value as? String;
                let kullaniciId=mesaj.childSnapshot(forPath: "kullaniciId").value as? String;
                let mesaj=Mesaj(icerik: icerik!, kullaniciEposta: kullaniciEposta!, kullaniciId: kullaniciId!);
                mesajDizi.append(mesaj);
            }
            sonuc(mesajDizi);
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
    
    func emailGetir(sorgu:String, sonuc:@escaping(_ epostaDizi:[String],_ idDizi:[String])->()){
        var epostalar=[String]();
        var idler=[String]();
        REF_KULLANICILAR.observe(.value) { (snapshot) in
            guard let kullaniciSnapshot = snapshot.children.allObjects as? [DataSnapshot] else{return;}
            
            for kullanici in kullaniciSnapshot{
                let eposta=kullanici.childSnapshot(forPath: "eposta").value as? String;
                let id=kullanici.key;
                print(id);
                if (eposta?.contains(sorgu))! == true && eposta != Auth.auth().currentUser?.email{
                    debugPrint("BBBB")
                    epostalar.append(eposta!);
                    idler.append(id);
                    debugPrint("BURAYA\(epostalar.count)");
                }
            }
            sonuc(epostalar,idler);
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
    
    func grupOlustur(baslik:String,aciklama:String,kullaniciEpostalari:[String],sonuc:@escaping (_ durum:Bool)->()){
        REF_GRUPLAR.childByAutoId().updateChildValues(["baslik":baslik,"aciklama":aciklama,"uyeler":kullaniciEpostalari]);
        sonuc(true);
    }
    
    func tumGruplariGetir(sonuc:@escaping(_ grupDizi:[Grup])->()){
        var grupDizi=[Grup]();
        var katilimciDizi=[String]();
        
        REF_GRUPLAR.observeSingleEvent(of: .value) { (grupSnapshot) in
            guard let grupSnapshot=grupSnapshot.children.allObjects as? [DataSnapshot] else {return};
            
            for grup in grupSnapshot{
                katilimciDizi=grup.childSnapshot(forPath: "uyeler").value as! [String];
                if katilimciDizi.contains((Auth.auth().currentUser?.email)!){
                    let grupBaslik=(grup.childSnapshot(forPath: "baslik").value as? String)!;
                    let grupAciklama=(grup.childSnapshot(forPath: "aciklama").value as? String)!;
                    let grupAnahtar=grup.key;
                    
                    let grup1=Grup(baslik: grupBaslik, aciklamma: grupAciklama, anahtar: grupAnahtar, katilimciSayisi: katilimciDizi.count, katilimcilar: katilimciDizi);
                    grupDizi.append(grup1);
                    debugPrint("BİLEMEM \(grupDizi.count)");
                }
            }
            sonuc(grupDizi);
        }
        

    }
    

    
}

