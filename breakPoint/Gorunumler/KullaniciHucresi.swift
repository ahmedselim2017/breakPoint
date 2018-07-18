//
//  KullaniciHucre.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 17.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import UIKit

class KullaniciHucresi: UITableViewCell {
    
    //UI Elemanları
    @IBOutlet weak var rsmProfil: UIImageView!
    @IBOutlet weak var rsmSec: UIImageView!
    
    @IBOutlet weak var lblEposta: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        rsmSec.isHidden = !(rsmSec.isHidden);
        
        // Configure the view for the selected state
    }
    
    func hucreleriAyarla(rsmProfil:UIImage,eposta:String,secilmisMi:Bool){
        self.rsmProfil.image=rsmProfil;
        self.lblEposta.text=eposta;
        debugPrint("jklkjdjksdjkldfjklsjkfdsjkldfsljkdfljksj AASS \(secilmisMi)")
        if secilmisMi{
            self.rsmSec.isHidden=false;
        }
        else{
            self.rsmSec.isHidden=true;
        }
    }

}
