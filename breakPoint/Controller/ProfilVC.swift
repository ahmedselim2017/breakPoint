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

    var mesajlar=[Mesaj]();
    
    @IBOutlet weak var txtEposta: UILabel!
    @IBOutlet weak var imgProfil: UIImageView!
    @IBOutlet weak var btnProfilDegistir: UIButton!
    @IBOutlet weak var tabloGoruntuleyici: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tabloGoruntuleyici.delegate=self;
        tabloGoruntuleyici.dataSource=self;
        // Do any additional setup after loading the view.
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        profilResimAyarla();
        if Auth.auth().currentUser?.email != nil{
            self.txtEposta.text=Auth.auth().currentUser?.email;
            VeriServisi.ornek.kullaniciFeedGerit(eposta: (Auth.auth().currentUser?.email)!) { (mesajlar) in
                self.mesajlar=mesajlar.reversed();
                debugPrint("\(self.mesajlar.count)");
                self.tabloGoruntuleyici.reloadData();
            }
        }
        else{
            self.txtEposta.text="Anonim";
        }
    }
    
    func profilResimAyarla(){
        VeriServisi.ornek.profilResmiGetir(kullaniciId: (Auth.auth().currentUser?.uid)!) { (resim) in
            self.imgProfil.image=resim;
        }

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
    
    @IBAction func btnProiflDegistirBasildi(_ sender: Any) {
        let resim=UIImagePickerController();
        
        resim.delegate=self;
        resim.sourceType=UIImagePickerController.SourceType.photoLibrary;
        resim.allowsEditing=true;
        
        present(resim , animated: true, completion: nil);

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

extension ProfilVC:UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let resim=info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{return;}

        
        VeriServisi.ornek.profilResmiEkle(kullaniciId: (Auth.auth().currentUser?.uid)!, resim: resim) { (durum) in
            if durum{
                debugPrint("İŞLEM BAŞARILI!!");
            }
        };
        
        self.dismissDetail();
    }
}


extension ProfilVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mesajlar.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let hucre=tableView.dequeueReusableCell(withIdentifier: TB_ID_PROFIL_FEED_HUCRESI) as? ProfilFeedHucresi else{return UITableViewCell();}
        hucre.hucreleriAyarla(icerik: self.mesajlar[indexPath.row].icerik);
        return hucre;
        
    }
}
