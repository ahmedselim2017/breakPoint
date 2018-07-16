//
//  FeedHucresi.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 16.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import UIKit

class FeedHucresi: UITableViewCell {

    @IBOutlet weak var imgProfil: UIImageView!
    @IBOutlet weak var lblEposta: UILabel!
    @IBOutlet weak var lblIcerik: UILabel!
    
    func hucreleriAyarla(imgProfil:UIImage,eposta:String,icerik:String){
        self.imgProfil.image=imgProfil;
        self.lblEposta.text=eposta;
        self.lblIcerik.text=icerik;
    }
}
