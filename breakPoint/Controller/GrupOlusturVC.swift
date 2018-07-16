//
//  GrupOlusturVC.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 17.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import UIKit

class GrupOlusturVC: UIViewController {

    @IBOutlet weak var txtBaslik: TxtGiris!
    @IBOutlet weak var txtAciklama: TxtGiris!
    @IBOutlet weak var txtKatilimcilar: TxtGiris!
    
    @IBOutlet weak var lblKatilimcilar: UILabel!
    
    @IBOutlet weak var tabloGoruntuleyici: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnGrupOlusturBasildi(_ sender: Any) {
    }
    
    @IBAction func btnGeriBasildi(_ sender: Any) {
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
