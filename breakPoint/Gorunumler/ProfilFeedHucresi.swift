//
//  ProfilFeedHucresi.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 18.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import UIKit

class ProfilFeedHucresi: UITableViewCell {

    @IBOutlet weak var lblIcerik: UILabel!
 
    
    func hucreleriAyarla(icerik:String){
        self.lblIcerik.text=icerik;
    }
    
}
