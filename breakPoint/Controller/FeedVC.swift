//
//  FirstViewController.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 13.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {
    
    var mesajlarDizisi=[Mesaj]();

    @IBOutlet weak var tabloGoruntuleyici: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tabloGoruntuleyici.delegate=self;
        tabloGoruntuleyici.dataSource=self;
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        VeriServisi.ornek.feedGetir { (mesajDizi) in
            self.mesajlarDizisi=mesajDizi.reversed();
            self.tabloGoruntuleyici.reloadData();
        }
    }
    
    

}

extension FeedVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mesajlarDizisi.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let hucre=tableView.dequeueReusableCell(withIdentifier: TB_ID_FEED_HUCRESI) as? FeedHucresi else{return UITableViewCell();}
        
        
        let mesaj=mesajlarDizisi[indexPath.row];
        
        let icerik=mesaj.icerik;
        VeriServisi.ornek.profilResmiGetir(kullaniciId: mesaj.kullaniciId) { (resim) in
            hucre.hucreleriAyarla(imgProfil: resim, eposta: "\(mesaj.kullaniciEposta)", icerik: icerik);
        }
        
        let eposta=mesaj.kullaniciEposta;
        return hucre;
        
    }
}
