//
//  GurupHucresi.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 17.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import UIKit

class GurupHucresi: UITableViewCell {

    @IBOutlet weak var lblGrupAdi: UILabel!
    @IBOutlet weak var lblGrupKullaniciSayisi: UILabel!
    @IBOutlet weak var lblGrupAciklamasi: UILabel!
    
    func hucreleriAyarla(baslik:String,aciklama:String,kullaniciSayisi:Int){
        self.lblGrupAciklamasi.text=aciklama;
        self.lblGrupAdi.text=baslik;
        self.lblGrupKullaniciSayisi.text="\(kullaniciSayisi) kişi";
    }
    
}
