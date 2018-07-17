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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tabloGoruntuleyici.delegate=self;
        tabloGoruntuleyici.dataSource=self;
    }


}


extension GrupVC:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let hucre = tableView.dequeueReusableCell(withIdentifier: TB_ID_GRUP_HUCRESI) as? GurupHucresi else{return UITableViewCell();}
        
        hucre.hucreleriAyarla(baslik: "Deneme", aciklama: "Deneme", kullaniciSayisi: 2);
        return hucre;
    }
}
