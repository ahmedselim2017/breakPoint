//
//  GirisYapVC.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 14.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import UIKit

class GirisYapVC: UIViewController {

    @IBOutlet weak var txtEposta: TxtGiris!
    @IBOutlet weak var txtSifre: TxtGiris!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        txtSifre.delegate=self;
        txtEposta.delegate=self;
    }
    
    @IBAction func girisYapBasildi(_ sender: Any) {
        if txtEposta.text != nil && txtSifre.text != nil{
            AuthServisi.ornek.kullaniciGirisYap(eposta: txtEposta.text!, sifre: txtSifre.text!) { (sonuc, hata) in
                if sonuc{
                    debugPrint("Giriş Başarılı");
                    self.dismiss(animated: true, completion: nil);
                }
                else{
                    debugPrint(self.txtSifre.text!);
                }
                AuthServisi.ornek.kullaniciKaydet(eposta: self.txtEposta.text!, sifre: self.txtSifre.text!, kullaniciKaydetmeBitis: { (durum, hata) in
                    if durum{
                        AuthServisi.ornek.kullaniciGirisYap(eposta: self.txtEposta.text!, sifre: self.txtSifre.text!, kullaniciGirisBitis: { (durum, nil) in
                            self.dismiss(animated: true, completion: nil);
                            debugPrint("YENİ KULLANICI");
                            
                        })
                    }
                    else{
                        debugPrint(hata?.localizedDescription);
                    }
                })
            }
        }
    }
    
    @IBAction func kapatmaBasildi(_ sender: Any) {
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

extension GirisYapVC:UITextFieldDelegate{
    
}
