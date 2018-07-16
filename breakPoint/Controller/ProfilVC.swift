//
//  ProfilVC.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 16.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import UIKit;
import Firebase;

class ProfilVC: UIViewController {

    @IBOutlet weak var txtEposta: UILabel!
    @IBOutlet weak var imgProfil: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.txtEposta.text=Auth.auth().currentUser?.email;
    }
    
    @IBAction func btnCikisYapBasildi(_ sender: Any) {
        let cikisYap=UIAlertController(title: "Çıkış Yap", message: "Çıkış yapmak istediğinizden emin misiniz?", preferredStyle: .actionSheet)
        let cikisYapAksiyon=UIAlertAction(title: "Çıkış Yap", style: .destructive ) { (btnTiklandi) in
            VeriServisi.ornek.kullaniciCikisYap(sonuc: { (durum, hata) in
                if durum{
                    let authVC=self.storyboard?.instantiateViewController(withIdentifier: SB_ID_AuthVC) as? AuthVC;
                    self.present(authVC!, animated: true, completion: nil);
                }
            })
        }
        let geriDonAksiyon=UIAlertAction(title: "Geri Dön", style: .default ) { (btnTiklandi) in
            self.dismiss(animated: true, completion: nil);
        }
        cikisYap.addAction(geriDonAksiyon);
        cikisYap.addAction(cikisYapAksiyon);
        present(cikisYap , animated: true, completion: nil);
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
