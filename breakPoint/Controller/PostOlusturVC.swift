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

    @IBOutlet weak var imgProfil: NSLayoutConstraint!
    @IBOutlet weak var lblEposta: UILabel!
    @IBOutlet weak var txaMesaj: UITextView!
    @IBOutlet weak var btnGonder: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnGonder.klavyeyeBaglan();
        txaMesaj.delegate=self;
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnGonderBasildi(_ sender: Any) {
        if txaMesaj.text != nil && txaMesaj.text != "Birşeyler Paylaşın..."{
            btnGonder.isEnabled=false;
            VeriServisi.ornek.feedPaylas(mesaj: txaMesaj.text!, kullaniciID: (Auth.auth().currentUser?.uid)!, groupAnahtari: nil) { (durum) in
                if durum{
                    self.btnGonder.isEnabled=true;
                    self.dismiss(animated: true, completion: nil);
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
