//
//  PostOlusturVC.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 16.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import UIKit;
import Firebase;
import FirebaseAuth;

class PostOlusturVC: UIViewController {

    @IBOutlet weak var imgProfil: UIImageView!
    @IBOutlet weak var lblEposta: UILabel!
    @IBOutlet weak var txaMesaj: UITextView!
    @IBOutlet weak var btnGonder: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnGonder.klavyeyeBaglan();
        txaMesaj.delegate=self;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        if Auth.auth().currentUser?.email != nil{
            self.lblEposta.text=Auth.auth().currentUser?.email;
        }
        else{
            self.lblEposta.text="Anonim"
        }
        VeriServisi.ornek.profilResmiGetir(kullaniciId: (Auth.auth().currentUser?.uid)!) { (resim) in
            self.imgProfil.image=resim;
        }
    }
    
    @IBAction func btnGonderBasildi(_ sender: Any) {
        if txaMesaj.text != nil && txaMesaj.text != "Birşeyler Paylaşın..."{
            btnGonder.isEnabled=false;
            
            var kullaniciEposta=Auth.auth().currentUser?.email;
            if kullaniciEposta == nil{
                kullaniciEposta="Anonim";
            }
            
            VeriServisi.ornek.feedPaylas(mesaj: txaMesaj.text!, kullaniciEposta: (kullaniciEposta)!, grupAnahtari: nil, kullaniciId: (Auth.auth().currentUser?.uid)!) { (durum) in
                if durum{
                    self.btnGonder.isEnabled=true;
                    self.dismissDetail();
                }
                else{
                    self.btnGonder.isEnabled=true;
                    debugPrint("37.SATIR HATA");
                }
            }
        }
    }
    
    @IBAction func btnKapatBasildi(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PostOlusturVC:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text="";
        textView.textColor=#colorLiteral(red: 0.6212110519, green: 0.8334299922, blue: 0.3770503998, alpha: 1);
    }
}
