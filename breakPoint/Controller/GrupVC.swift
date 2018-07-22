//
//  SecondViewController.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 13.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import UIKit

class GrupVC: UIViewController {

    @IBOutlet weak var tabloGoruntuleyici: UITableView!
    
    var grupDizi=[Grup]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tabloGoruntuleyici.delegate=self;
        tabloGoruntuleyici.dataSource=self;
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        VeriServisi.ornek.REF_GRUPLAR.observeSingleEvent(of: .value) { (snapshot) in
            VeriServisi.ornek.tumGruplariGetir { (grupdizi) in
                self.grupDizi=grupdizi.reversed();
                debugPrint("NEDEN OLMADI \(grupdizi.count)")
                self.tabloGoruntuleyici.reloadData();
            }
        }
    }
   
    
}


extension GrupVC:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return grupDizi.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let hucre = tableView.dequeueReusableCell(withIdentifier: TB_ID_GRUP_HUCRESI) as? GurupHucresi else{return UITableViewCell();}
        
        let grup=grupDizi[indexPath.row];
        hucre.hucreleriAyarla(baslik: grup.grupBaslik, aciklama: grup.grupAciklama, kullaniciSayisi: grup.katilimciSayisi);
        return hucre;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let grupFeedVC=storyboard?.instantiateViewController(withIdentifier: SB_ID_GrupFeedVC) as? GrupFeedVC else{return};
        grupFeedVC.initVeri(grup: grupDizi[indexPath.row]);
        self.presentDetail(grupFeedVC);
    }
}
